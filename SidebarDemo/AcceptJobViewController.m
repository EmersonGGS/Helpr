//
//  AcceptJobViewController.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/22/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AcceptJobViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"

@interface AcceptJobViewController ()

@end

@implementation AcceptJobViewController

@synthesize titleLabel;
@synthesize addressLabel;
@synthesize timeLabel;
@synthesize dateLabel;
@synthesize hoursLabel;
@synthesize notesLabel;
@synthesize passedArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    titleLabel.text = [passedArray objectAtIndex:0];
    addressLabel.text = [passedArray objectAtIndex:4];
    timeLabel.text = [passedArray objectAtIndex:2];
    dateLabel.text = [passedArray objectAtIndex:1];
    hoursLabel.text = [passedArray objectAtIndex:3];
    notesLabel.text = [passedArray objectAtIndex:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//If user doesn't want the job
- (IBAction)declineJob:(id)sender {
    //[self performSegueWithIdentifier: @"declineJobId" sender: self];
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

//If user wants the job
- (IBAction)acceptJob:(id)sender {
    
    UIAlertView* thanks = [[UIAlertView alloc] initWithTitle:@"Accepted!"
                                                message:@"Wicked! Thanks for accepting this job. Don't forget to get your employers signature at the end" delegate:self cancelButtonTitle:@"Yeah, no Biggie." otherButtonTitles: nil];
    [thanks show];
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFObject *ongoingObj = [PFObject objectWithClassName:@"Ongoing"];
    ongoingObj[@"address"] = [passedArray objectAtIndex:4];
    ongoingObj[@"date"] = [passedArray objectAtIndex:1];
    ongoingObj[@"startTime"] = [passedArray objectAtIndex:2];
    ongoingObj[@"title"] = [passedArray objectAtIndex:0];
    ongoingObj[@"numofHours"] = [passedArray objectAtIndex:3];
    ongoingObj[@"phoneNumber"] = [passedArray objectAtIndex:6];
    ongoingObj[@"workerEmail"] = currentUser.email;
    ongoingObj[@"notes"] = [passedArray objectAtIndex:5];
    [ongoingObj saveInBackground];
    
    //Query to remove job from Jobs class
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query whereKey:@"objectId" equalTo:[passedArray objectAtIndex:7]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [object deleteInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];}
@end
