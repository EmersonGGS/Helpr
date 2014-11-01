//
//  OngoingOptionsViewController.h
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-10-28.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OngoingOptionsViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *passedArray;

- (IBAction)signatureBtnFunction:(id)sender;
- (IBAction)phoneBtnFunction:(id)sender;
- (IBAction)cancelBtnFunction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;
@property (strong, nonatomic) IBOutlet UIButton *signatureBtn;

@end
