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
#import "SignatureViewController.h"


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
    

    
    self.cancelBtn.backgroundColor = [UIColor colorWithRed:0.933 green:0.333 blue:0.396 alpha:1];
    self.phoneBtn.backgroundColor = [UIColor colorWithRed:0.357 green:0.761 blue:0.655 alpha:1];
    self.signatureBtn.backgroundColor = [UIColor colorWithRed:0.357 green:0.761 blue:0.655 alpha:1];
    
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    
    self.phoneBtn.layer.cornerRadius = 5;
    self.phoneBtn.layer.masksToBounds = YES;
    
    self.signatureBtn.layer.cornerRadius = 5;
    self.signatureBtn.layer.masksToBounds = YES;
    
    NSLog(@"PassedArray: %@", passedArray);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signatureBtnFunction:(id)sender {
    [self performSegueWithIdentifier: @"signatureSegue" sender:self];
       [_signatureBtn setAlpha:0.42];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"signatureSegue"]) {
        SignatureViewController *transferViewController = segue.destinationViewController;
        transferViewController.completedJobArray = [[NSMutableArray alloc]init];
        transferViewController.completedJobArray = self.passedArray;
    }
}

//phone the job
- (IBAction)phoneBtnFunction:(id)sender {
    NSString *jobPhoneNumber = [self.passedArray objectAtIndex:6];
    NSString *numToCall = [@"tel:" stringByAppendingString:jobPhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numToCall]];
       [_phoneBtn setAlpha:0.42];
    
}

//User no longer wants the job
- (IBAction)cancelBtnFunction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Woahhhh there!"
                                                   message: @"Are you sure you would like to decline this job?"
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Yes",nil];
    
    [alert setTag:1];
    [alert show];
    [_cancelBtn setAlpha:0.42];
    
    

    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) { // UIAlertView with tag 1 detected
        if (buttonIndex == 0)
        {
            NSLog(@"user pressed Button Indexed 0");
            [_cancelBtn setAlpha:1.00];
        }
        else
        {
            NSLog(@"user pressed Button Indexed 1");
          
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
    }

}





@end
