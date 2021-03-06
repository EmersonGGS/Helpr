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

@implementation JobsTableViewController {
    NSMutableArray *contentArray;
}

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
    
    [self viewWillAppear:NO];
    contentArray = [[NSMutableArray alloc] init];
    
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
    self.notesArray = [[NSMutableArray alloc] init];
    self.phoneArray = [[NSMutableArray alloc] init];
    self.namesArray = [[NSMutableArray alloc] init];
    self.objectIdArray = [[NSMutableArray alloc] init];
    
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
                NSString *notesString = object[@"notes"];
                NSString *phoneString = object[@"phoneNumber"];
                NSString *objectIdString = object.objectId;
                NSString *nameString = object[@"employerName"];
                
                //add initialized vars into appropriate arrays
                [self.titlesArray addObject:titleString];
                [self.dateArray addObject:dateString];
                [self.timeArray addObject:timeString];
                [self.hoursArray addObject:hoursString];
                [self.addressArray addObject:addressString];
                [self.notesArray addObject:notesString];
                [self.phoneArray addObject:phoneString];
                [self.objectIdArray addObject:objectIdString];
                [self.namesArray addObject:nameString];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
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
    //create for display purposes
    NSString *hourLabel = @"Hours: ";
    NSString *combined = [NSString stringWithFormat:@"%@%@", hourLabel, [self.hoursArray objectAtIndex:indexPath.row]];
    cell.titleLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    cell.dateTimeLabel.text = [self.dateArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = [self.timeArray objectAtIndex:indexPath.row];
    cell.hoursTimeLabel.text = combined;
    cell.addressLabel.text = [self.addressArray objectAtIndex:indexPath.row];
    
    NSLog(@"address %@", cell.addressLabel.text);
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    //clear content
    contentArray = [[NSMutableArray alloc] init];
    
    //set new content
    [contentArray addObject:[self.titlesArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.dateArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.timeArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.hoursArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.addressArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.notesArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.phoneArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.objectIdArray objectAtIndex:indexPath.row]];
    [contentArray addObject:[self.namesArray objectAtIndex:indexPath.row]];
    
    NSLog(@"%@", contentArray);
    [self performSegueWithIdentifier: @"acceptJob" sender: self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"acceptJob"]) {
        AcceptJobViewController *transferViewController = segue.destinationViewController;
        transferViewController.passedArray = [[NSMutableArray alloc]init];
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
