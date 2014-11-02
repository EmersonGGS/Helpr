//
//  AcceptJobViewController.h
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/22/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AcceptJobViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) NSMutableArray *passedArray;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@property (weak, nonatomic) IBOutlet UIButton *declineBtn;
@property (weak, nonatomic) IBOutlet UIButton *accept;
@property (weak, nonatomic) IBOutlet UIButton *decline;

- (IBAction)acceptJob:(id)sender;
- (IBAction)declineJob:(id)sender;
@end
