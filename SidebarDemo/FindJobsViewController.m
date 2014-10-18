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
    CGFloat screenHeight = screenSize.height;
    
    //ref to the current view
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    self.view = mainScrollView;
    [mainScrollView setScrollEnabled:YES];
    int scrollHeight = 0;
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //create counter
            int counterInt = 0;
            for (PFObject *object in objects) {
                counterInt+=1;
                NSLog(@"Successfully retrieved %d objects.", objects.count);
                scrollHeight+=(10+120*counterInt);
                
                UIView *centerView = [[UIView alloc] init];
                CGRect frame = CGRectMake(0, (10+120*counterInt), 400, 100);
                centerView.frame = frame;
                centerView.backgroundColor = [UIColor redColor];
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
