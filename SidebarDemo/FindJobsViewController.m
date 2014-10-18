//
//  FindJobsViewController.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "FindJobsViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface FindJobsViewController ()



@end

@implementation FindJobsViewController

int scrollHeight = 0;  // Or any other default value.

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
    // Do any additional setup after loading the view=['_{:view.backgroundColor = [UIColor colorWithRed:0.667 green:0.796 blue:0.655 alpha:1.0];
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    //get screen values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    
    //ref to the current view
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    self.view = mainScrollView;
    [mainScrollView setScrollEnabled:YES];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //create counter
            int counterInt = 0;
            for (PFObject *object in objects) {
                NSLog(@"Successfully retrieved %d objects.", objects.count);
                scrollHeight+=240;
                
                UIView *centerView = [[UIView alloc] init];
                if (counterInt == 0) {
                    CGRect frame = CGRectMake(0, 0, 400, 150);
                    centerView.frame = frame;
                    centerView.backgroundColor = [UIColor redColor];
                }
                else{
                    CGRect frame = CGRectMake(0, (180*counterInt), 400, 150);
                    centerView.frame = frame;
                    centerView.backgroundColor = [UIColor redColor];
                }
                counterInt+=1;
                
                //adding named label to new view
                UILabel  * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 400, 50)];
                titleLabel.backgroundColor = [UIColor clearColor];
                titleLabel.textAlignment = UITextAlignmentLeft; // UITextAlignmentCenter, UITextAlignmentLeft
                titleLabel.textColor=[UIColor whiteColor];
                titleLabel.text = object[@"title"];
                [titleLabel setFont:[UIFont systemFontOfSize:24]];
                [centerView addSubview:titleLabel];
                
                //adding named label to new view
                UILabel  * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 130, 30)];
                dateLabel.backgroundColor = [UIColor clearColor];
                dateLabel.textAlignment = UITextAlignmentLeft; // UITextAlignmentCenter, UITextAlignmentLeft
                dateLabel.textColor=[UIColor whiteColor];
                dateLabel.text = object[@"date"];
                [centerView addSubview:dateLabel];
                
                //adding named label to new view
                UILabel  * startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 160, 50)];
                startTimeLabel.backgroundColor = [UIColor clearColor];
                startTimeLabel.textAlignment = UITextAlignmentLeft; // UITextAlignmentCenter, UITextAlignmentLeft
                startTimeLabel.textColor=[UIColor whiteColor];
                startTimeLabel.text = object[@"startTime"];
                [centerView addSubview:startTimeLabel];
                
                //adding named label to new view
                UILabel  * numHoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
                numHoursLabel.backgroundColor = [UIColor clearColor];
                numHoursLabel.textAlignment = UITextAlignmentLeft; // UITextAlignmentCenter, UITextAlignmentLeft
                numHoursLabel.textColor=[UIColor whiteColor];
                numHoursLabel.text = object[@"numofHours"];
                [centerView addSubview:numHoursLabel];
                
                //adding named label to new view
                UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 400, 50)];
                addressLabel.backgroundColor = [UIColor clearColor];
                addressLabel.textAlignment = UITextAlignmentLeft; // UITextAlignmentCenter, UITextAlignmentLeft
                addressLabel.textColor=[UIColor whiteColor];
                addressLabel.text = object[@"address"];
                [centerView addSubview:addressLabel];
                
                UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [acceptBtn addTarget:self
                           action:@selector(aMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
                [acceptBtn setTitle:@"Accept Job" forState:UIControlStateNormal];
                acceptBtn.frame = CGRectMake(220, 110, 100, 40);
                UIColor *bgColour =[[UIColor alloc]initWithRed:46.0/255.0 green:204.0/255.0 blue:113.0/255.0 alpha:1.0];
                acceptBtn.backgroundColor=bgColour;
                [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [centerView addSubview:acceptBtn];

                
                // put the flake in our main view
                [self.view addSubview:centerView];
            }
            [mainScrollView setContentSize:CGSizeMake(screenWidth, scrollHeight)];
        } else {
            // The request failed
        }
        
    }];
    
    
    
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
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
