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
    
    UIColor *bgColour = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    self.view.backgroundColor = bgColour;
    
    
    
    titleLabel.text = [passedArray objectAtIndex:0];
    addressLabel.text = [passedArray objectAtIndex:4];
    timeLabel.text = [passedArray objectAtIndex:2];
    dateLabel.text = [passedArray objectAtIndex:1];
    hoursLabel.text = [passedArray objectAtIndex:3];
    notesLabel.text = [passedArray objectAtIndex:5];
    
    
    
    
    _accept.backgroundColor = [UIColor colorWithRed:0.357 green:0.761 blue:0.655 alpha:1];
    
    _accept.layer.cornerRadius = 5;
    _accept.layer.masksToBounds = YES;
    
    _decline.backgroundColor = [UIColor colorWithRed:0.933 green:0.333 blue:0.396 alpha:1];
    
    _decline.layer.cornerRadius = 5;
    _decline.layer.masksToBounds = YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}







//If user doesn't want the job
- (IBAction)declineJob:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    ongoingObj[@"employerName"] = [passedArray objectAtIndex:8];
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
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
