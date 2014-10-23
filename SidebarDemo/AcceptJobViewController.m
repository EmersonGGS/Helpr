//
//  AcceptJobViewController.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/22/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AcceptJobViewController.h"

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
    // Do any additional setup after loading the view.
    
    self.passedArray = [[NSMutableArray alloc] init];
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

@end
