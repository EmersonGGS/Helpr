//
//  loginViewController.m
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-11.
//

#import "loginViewController.h"
#import <Parse/Parse.h>
@interface loginViewController ()

@end

@implementation loginViewController

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
    
    UIColor *bgColour = [[UIColor alloc]initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0];
    self.view.backgroundColor = bgColour;
    
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    self.username.delegate = self;
    self.password.delegate = self;
    
    self.username.borderStyle = UITextBorderStyleNone;
    self.username.backgroundColor = [UIColor whiteColor];
    self.password.borderStyle = UITextBorderStyleNone;
    self.password.backgroundColor = [UIColor whiteColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.username.leftView = paddingView;
    self.username.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.password.leftView = paddingView2;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    //Adding border Colours
    self.username.layer.borderColor=[[UIColor colorWithRed:84.0/255.0f green:84.0/255.0f blue:84.0/255.0f alpha:1.0] CGColor];
    self.username.layer.borderWidth=3.0;
    self.password.layer.borderColor=[[UIColor colorWithRed:84.0/255.0f green:84.0/255.0f blue:84.0/255.0f alpha:1.0] CGColor];
    self.password.layer.borderWidth=3.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSString *username = [self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username and password!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                [self performSegueWithIdentifier:@"BringToMain" sender:sender];
                
            }
        }];
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
