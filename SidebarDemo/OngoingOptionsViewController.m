//
//  OngoingOptionsViewController.m
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-10-28.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "OngoingOptionsViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface OngoingOptionsViewController ()

@end

@implementation OngoingOptionsViewController

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
    // Do any additional setup after loading the view.
    
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
    
    NSLog(@"PassedArray: %@", passedArray);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signatureBtnFunction:(id)sender {
    [self performSegueWithIdentifier: @"signatureSegue" sender:self];
}

//phone the job
- (IBAction)phoneBtnFunction:(id)sender {
    NSString *jobPhoneNumber = [self.passedArray objectAtIndex:6];
    NSString *numToCall = [@"tel:" stringByAppendingString:jobPhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numToCall]];
    
}

//User no longer wants the job
- (IBAction)cancelBtnFunction:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Ongoing"];
    [query getObjectInBackgroundWithId:[self.passedArray objectAtIndex:7] block:^(PFObject *object, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        
        [object deleteInBackground];
        
        NSLog(@"Deleted: %@", object);
        [self performSegueWithIdentifier: @"cancelJobSegue" sender:self];
        
    }];
    
    //putting job back in bank so it can be accepted by a different user
    PFObject *revertJob = [PFObject objectWithClassName:@"Jobs"];
    revertJob[@"title"] = [self.passedArray objectAtIndex:0];
    revertJob[@"date"] = [self.passedArray objectAtIndex:1];
    revertJob[@"startTime"] = [self.passedArray objectAtIndex:2];
    revertJob[@"numofHours"] = [self.passedArray objectAtIndex:3];
    revertJob[@"address"] = [self.passedArray objectAtIndex:4];
    revertJob[@"notes"] = [self.passedArray objectAtIndex:5];
    revertJob[@"phoneNumber"] = [self.passedArray objectAtIndex:6];
    
    [revertJob saveInBackground];
}
@end
