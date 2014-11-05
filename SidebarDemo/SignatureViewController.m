//
//  SignatureViewController.m
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-10-28.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SignatureViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "OngoingTableViewController.h"

@interface SignatureViewController ()

@end

@implementation SignatureViewController

@synthesize mainImage;
@synthesize tempDrawImage;
@synthesize completedJobArray;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    NSLog(@"passed data: %@", self.completedJobArray);
    
    UIColor *bgColour = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.view.backgroundColor = bgColour;
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 3.0;
    opacity = 1.0;
    
    
   // _backgroundText.transform = CGAffineTransformMakeRotation( M_PI / 2 );

    _save.transform = CGAffineTransformMakeRotation( M_PI / 2 );
    _reset.transform = CGAffineTransformMakeRotation( M_PI / 2 );
    
      _save.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1];
    _reset.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1];

    }

- (void)viewDidUnload
{
    
    // UIColor *bgColour = [UIColor colorWithRed:0.694 green:9.878 blue:0.871 alpha:1];
    //self.view.backgroundColor = bgColour;
    
    [self setMainImage:nil];
    [self setTempDrawImage:nil];
    [super viewDidUnload];
    
    
    
    
    //   self.save.borderStyle = UITextBorderStyleNone;
    
    //self.save.backgroundColor = [UIColor redColor];
    
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (IBAction)reset:(id)sender {
    
    self.mainImage.image = nil;
    
}




- (IBAction)save:(id)sender {

        
        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
       
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        NSData *imageData = UIImagePNGRepresentation(SaveImage);
        
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
         
        NSLog(@"array: %@", self.completedJobArray);
         PFUser *currentUser = [PFUser currentUser];
         
         PFObject *completedObj = [PFObject objectWithClassName:@"Completed"];
         completedObj[@"address"] = [completedJobArray objectAtIndex:4];
         completedObj[@"date"] = [completedJobArray objectAtIndex:1];
         completedObj[@"startTime"] = [completedJobArray objectAtIndex:2];
         completedObj[@"title"] = [completedJobArray objectAtIndex:0];
         completedObj[@"numofHours"] = [completedJobArray objectAtIndex:3];
         completedObj[@"phoneNumber"] = [completedJobArray objectAtIndex:6];
         completedObj[@"workerEmail"] = currentUser.email;
         completedObj[@"notes"] = [completedJobArray objectAtIndex:5];
        completedObj[@"employerName"] = [completedJobArray objectAtIndex:8];
         
         completedObj[@"signature"] = imageFile;
         [completedObj saveInBackground];
        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Way to go kid! You completed some more volunteer hours!"  delegate:self cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
    [alert show];

    
   /*      //Query to remove job from Jobs class
         PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
         [query whereKey:@"objectId" equalTo:[passedArray objectAtIndex:7]];
         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (!error) {
         // The find succeeded.
         NSLog(@"Successfully retrieved %d scores.", objects.count);
         // Do something with the found objects
         for (PFObject *object in objects) {
         [object deleteInBackground];
         }
         } else {
         // Log details of the failure
         NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
         
         }];
        */
        
        
        
  
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        NSLog(@"AlertView Ok has been clicked");
       
        
        
    }else{
    
    
    
    }

}
        // Do something
      








- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}



#pragma mark - SettingsViewControllerDelegate methods



@end
