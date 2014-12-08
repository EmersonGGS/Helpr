//
//  completedJobsViewController.h
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-12-07.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface completedJobsViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)closeModal:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
