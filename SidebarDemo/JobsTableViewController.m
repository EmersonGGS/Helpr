//
//  JobsTableViewController.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "JobsTableViewController.h"
#import "JobTableViewCell.h"
#import "SWRevealViewController.h"
#import "AcceptJobViewController.h"
#import <Parse/Parse.h>

@interface JobsTableViewController ()

@end

@implementation JobsTableViewController

@synthesize contentArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *bgColour = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.view.backgroundColor = bgColour;
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    self.titlesArray = [[NSMutableArray alloc] init];
    self.dateArray = [[NSMutableArray alloc] init];
    self.timeArray = [[NSMutableArray alloc] init];
    self.hoursArray = [[NSMutableArray alloc] init];
    self.addressArray = [[NSMutableArray alloc] init];
    self.contentArray = [[NSMutableArray alloc] init];
    
    PFQuery *updateTableArray = [PFQuery queryWithClassName:@"Jobs"];
    [updateTableArray findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d objects.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //Init variables from parse
                NSString *titleString = object[@"title"];
                NSString *dateString = object[@"date"];
                NSString *timeString = object[@"startTime"];
                NSString *hoursString = object[@"numofHours"];
                NSString *addressString = object[@"address"];
                
                //add initialized vars into appropriate arrays
                [self.titlesArray addObject:titleString];
                [self.dateArray addObject:dateString];
                [self.timeArray addObject:timeString];
                [self.hoursArray addObject:hoursString];
                [self.addressArray addObject:addressString];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titlesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *jobCellIdentifier = @"JobViewCellid";
    
    JobTableViewCell *cell = (JobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:jobCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JobTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *hoursText = [NSString stringWithFormat: @"Hours: %@", [self.hoursArray objectAtIndex:indexPath.row]];
    
    cell.titleLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    cell.dateTimeLabel.text = [self.dateArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = [self.timeArray objectAtIndex:indexPath.row];
    cell.hoursTimeLabel.text = hoursText;
    cell.addressLabel.text = [self.addressArray objectAtIndex:indexPath.row];
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    static NSString *jobCellIdentifier = @"JobViewCellid";
    JobTableViewCell *cell = (JobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:jobCellIdentifier];
    
    [contentArray addObject:cell.titleLabel.text];
    [contentArray addObject:cell.dateTimeLabel.text];
    [contentArray addObject:cell.timeLabel.text];
    [contentArray addObject:cell.hoursTimeLabel.text];
    [contentArray addObject:cell.addressLabel.text];
    [self performSegueWithIdentifier: @"acceptJob" sender: self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"acceptJob"]) {
        AcceptJobViewController *transferViewController = segue.destinationViewController;
        transferViewController.passedArray = contentArray;
    }
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1]; /*#f9f9f9*/
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101;
}

@end
