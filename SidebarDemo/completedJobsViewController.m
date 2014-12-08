//
//  completedJobsViewController.m
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-12-07.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "completedJobsViewController.h"
#import <Parse/Parse.h>

@interface completedJobsViewController ()

@end

@implementation completedJobsViewController
int currentCount = 0;
int totalObjects = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    currentCount = 0;
    totalObjects = 0;
    
    _backBtn.backgroundColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    _backBtn.layer.cornerRadius = 5;
    _backBtn.layer.masksToBounds = YES;
    
    UIColor *bgColour = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1] ;
    self.view.backgroundColor = bgColour;
    
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *updateTableArray = [PFQuery queryWithClassName:@"Completed"];
    [updateTableArray whereKey:@"workerEmail" equalTo:currentUser.email];
    [updateTableArray findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d objects.", objects.count);
            int totalObjects = objects.count;
            CGSize scrollViewContentSize = CGSizeMake(320, (60+60*totalObjects));
            [self.mainScrollView setContentSize:scrollViewContentSize];
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                if (currentCount == 0) {
                    UIView *completedSubView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, 420, 60)];
                    completedSubView.backgroundColor = [UIColor colorWithRed:0.31 green:0.373 blue:0.435 alpha:1] /*#4f5f6f*/;
                    
                    UIImageView *check =[[UIImageView alloc] initWithFrame:CGRectMake(10,20,20,20)];
                    check.image=[UIImage imageNamed:@"completedCheck.png"];
                    check.contentMode = UIViewContentModeScaleAspectFit;
                    [completedSubView addSubview:check];

                    
                    UILabel *jobTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 400, 30)];
                    jobTitle.backgroundColor = [UIColor clearColor];
                    jobTitle.textAlignment = NSTextAlignmentLeft;
                    jobTitle.textColor = [UIColor whiteColor];
                    jobTitle.numberOfLines = 0;
                    jobTitle.lineBreakMode = UILineBreakModeWordWrap;
                    jobTitle.text = object[@"title"];
                    [completedSubView addSubview:jobTitle];
                    
                    NSString *hourLabel = @"Hours Earned: ";
                    NSString *combined = [NSString stringWithFormat:@"%@%@", hourLabel, object[@"numofHours"]];
                    
                    
                    UILabel *hoursTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 400, 20)];
                    hoursTitle.backgroundColor = [UIColor clearColor];
                    hoursTitle.textAlignment = NSTextAlignmentLeft;
                    hoursTitle.textColor = [UIColor whiteColor];
                    hoursTitle.numberOfLines = 0;
                    hoursTitle.lineBreakMode = UILineBreakModeWordWrap;
                    hoursTitle.text = combined;
                    hoursTitle.font=[hoursTitle.font fontWithSize:14];
                    [completedSubView addSubview:hoursTitle];
                    
                    UILabel *completionTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 400, 20)];
                    completionTitle.backgroundColor = [UIColor clearColor];
                    completionTitle.textAlignment = NSTextAlignmentLeft;
                    completionTitle.textColor = [UIColor whiteColor];
                    completionTitle.numberOfLines = 0;
                    completionTitle.lineBreakMode = UILineBreakModeWordWrap;
                    completionTitle.text = object[@"date"];
                    completionTitle.font=[completionTitle.font fontWithSize:13];
                    [completedSubView addSubview:completionTitle];
                    
                    [self.mainScrollView addSubview:completedSubView];
                } else{
                    UIView *completedSubView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0+(65*currentCount), 420, 60)];
                    completedSubView.backgroundColor = [UIColor colorWithRed:0.31 green:0.373 blue:0.435 alpha:1] /*#4f5f6f*/;
                    
                    UIImageView *check =[[UIImageView alloc] initWithFrame:CGRectMake(10,20,20,20)];
                    check.image=[UIImage imageNamed:@"completedCheck.png"];
                    check.contentMode = UIViewContentModeScaleAspectFit;
                    [completedSubView addSubview:check];
                    
                    
                    UILabel *jobTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 400, 30)];
                    jobTitle.backgroundColor = [UIColor clearColor];
                    jobTitle.textAlignment = NSTextAlignmentLeft;
                    jobTitle.textColor = [UIColor whiteColor];
                    jobTitle.numberOfLines = 0;
                    jobTitle.lineBreakMode = UILineBreakModeWordWrap;
                    jobTitle.text = object[@"title"];
                    [completedSubView addSubview:jobTitle];
                    
                    NSString *hourLabel = @"Hours Earned: ";
                    NSString *combined = [NSString stringWithFormat:@"%@%@", hourLabel, object[@"numofHours"]];
                    
                    
                    UILabel *hoursTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 400, 20)];
                    hoursTitle.backgroundColor = [UIColor clearColor];
                    hoursTitle.textAlignment = NSTextAlignmentLeft;
                    hoursTitle.textColor = [UIColor whiteColor];
                    hoursTitle.numberOfLines = 0;
                    hoursTitle.lineBreakMode = UILineBreakModeWordWrap;
                    hoursTitle.text = combined;
                    hoursTitle.font=[hoursTitle.font fontWithSize:14];
                    [completedSubView addSubview:hoursTitle];
                    
                    UILabel *completionTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 400, 20)];
                    completionTitle.backgroundColor = [UIColor clearColor];
                    completionTitle.textAlignment = NSTextAlignmentLeft;
                    completionTitle.textColor = [UIColor whiteColor];
                    completionTitle.numberOfLines = 0;
                    completionTitle.lineBreakMode = UILineBreakModeWordWrap;
                    completionTitle.text = object[@"date"];
                    completionTitle.font=[completionTitle.font fontWithSize:13];
                    [completedSubView addSubview:completionTitle];
                    
                    [self.mainScrollView addSubview:completedSubView];
                }
                currentCount = currentCount + 1;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    self.mainScrollView.delegate = self;
    self.mainScrollView.scrollEnabled = YES;
    
}

- (IBAction)closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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


@end
