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

    NSLog(@"contentArray: %@", passedArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    PFObject *ongoingObj = [PFObject objectWithClassName:@"Ongoing"];
    ongoingObj[@"score"] = @1337;
    ongoingObj[@"playerName"] = @"Sean Plott";
    ongoingObj[@"cheatMode"] = @NO;
    [ongoingObj saveInBackground];
    
}
@end
