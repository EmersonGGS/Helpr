//
//  ProfileViewController.h
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *hoursCompleted;
@property (weak, nonatomic) IBOutlet UIButton *volunteerForm;

@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSMutableArray *hoursArray;
@property (strong, nonatomic) NSMutableArray *addressArray;
@property (strong, nonatomic) NSMutableArray *phoneArray;
@property (strong, nonatomic) NSMutableArray *nameArray;

- (IBAction)saveHoursPDF:(id)sender;

@end
