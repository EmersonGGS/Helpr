//
//  signUpViewController.m
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-11.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "signUpViewController.h"
#import <Parse/Parse.h>

@interface signUpViewController ()

@end

@implementation signUpViewController

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
    self.username.delegate = self;
    self.password.delegate = self;
    self.email.delegate = self;
    
  UIColor *bgColour = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1] ;
    self.view.backgroundColor = bgColour;
    
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    self.username.borderStyle = UITextBorderStyleNone;
    self.username.backgroundColor = [UIColor whiteColor];
    
    self.email.borderStyle = UITextBorderStyleNone;
    self.email.backgroundColor = [UIColor whiteColor];
    self.password.borderStyle = UITextBorderStyleNone;
    self.password.backgroundColor = [UIColor whiteColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.username.leftView = paddingView;
    self.username.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.email.leftView = paddingView1;
    self.email.leftViewMode = UITextFieldViewModeAlways;

    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.password.leftView = paddingView2;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    //Adding border Colours
    self.username.layer.borderColor=[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
    self.username.layer.borderWidth=1.0;
    self.email.layer.borderColor=[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
    self.email.layer.borderWidth=1.0;
    self.password.layer.borderColor=[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
    self.password.layer.borderWidth=1.0;
    
    
    
    
    self.username.layer.cornerRadius = 5;
    self.username.layer.masksToBounds = YES;
    self.password.layer.cornerRadius = 5;
    self.password.layer.masksToBounds = YES;
    self.email.layer.cornerRadius = 5;
    self.email.layer.masksToBounds = YES;
    _signup.layer.cornerRadius = 5;
    _signup.layer.masksToBounds = YES;
     _signup.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup:(id)sender {
    NSString *username = [self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username, password, and email address!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                [self performSegueWithIdentifier:@"BringToApp" sender:sender];
            }
        }];
    }

}

- (IBAction)backbtn:(id)sender {
}
// moves view when keyboard is displayed

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField *)textField up: (BOOL) up
{
    const int movementDistance = 70;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - UITextField delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
