//
//  ProfileViewController.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
#define kPadding 20

@interface ProfileViewController ()
{
    CGSize _pageSize;
}


@end

@implementation ProfileViewController

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
    
    UIColor *bgColour = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.view.backgroundColor = bgColour;
    
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    
    [[PFUser currentUser] objectForKey:@"username"];
    
    NSString* user = [[PFUser currentUser] objectForKey:@"username"];
    
    self.username.text = user;

    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
   
    _volunteerForm.backgroundColor = [UIColor colorWithRed:0.357 green:0.761 blue:0.655 alpha:1];
    
    _volunteerForm.layer.cornerRadius = 5;
    _volunteerForm.layer.masksToBounds = YES;
    //Getting current user for query
    PFUser *currentUser = [PFUser currentUser];
    
    self.titlesArray = [[NSMutableArray alloc] init];
    self.dateArray = [[NSMutableArray alloc] init];
    self.timeArray = [[NSMutableArray alloc] init];
    self.hoursArray = [[NSMutableArray alloc] init];
    self.addressArray = [[NSMutableArray alloc] init];
    self.phoneArray = [[NSMutableArray alloc] init];
    self.nameArray = [[NSMutableArray alloc] init];
    self.signatureArray = [[NSMutableArray alloc] init];
    
    
    //Query for completed jobs from signed in user
    PFQuery *query = [PFQuery queryWithClassName:@"Completed"];
    [query whereKey:@"workerEmail" equalTo:currentUser.email];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {            // The find succeeded.
            NSLog(@"Successfully retrieved %d objects.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                //Init variables from parse
                NSString *titleString = object[@"title"];
                NSString *dateString = object[@"date"];
                NSString *timeString = object[@"startTime"];
                NSString *hoursString = object[@"numofHours"];
                NSString *addressString = object[@"address"];
                NSString *phoneString = object[@"phoneNumber"];
                NSString *nameString = object[@"employerName"];
                PFFile *parseFileSig = object[@"signature"];
                [parseFileSig getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        [self.signatureArray addObject:image];
                    }
                }];
                UIImage *parseSignature = object[@"signature"];
                
                //add initialized vars into appropriate arrays
                [self.titlesArray addObject:titleString];
                [self.dateArray addObject:dateString];
                [self.timeArray addObject:timeString];
                [self.hoursArray addObject:hoursString];
                [self.addressArray addObject:addressString];
                [self.phoneArray addObject:phoneString];
                [self.nameArray addObject:nameString];
                
                NSLog(@"Images array? %@", self.signatureArray);
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveHoursPDF:(id)sender {
    
    [self setupPDFDocumentNamed:@"HelprHours" Width:2550 Height:3300];
    
    [self beginPDFPage];
    
    ///////////////
    //PDF Header//
    /////////////
    
    //header bg bar
    CGRect headerDivider = [self addLineWithFrame:CGRectMake(0, 0, _pageSize.width, 450)
                                        withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    //header HELPR img
    UIImage *anImage = [UIImage imageNamed:@"helpr-logo.png"];
    CGRect imageRect = [self addImage:anImage
                              withFrame:CGRectMake((_pageSize.width/2)-(anImage.size.width/2), kPadding, 400, 400)];
    
    /////////////////////
    //User Information//
    ///////////////////
    
    //School name
    CGRect schoolTitleRect = [self addText:@"Emerson George Stewart"
                                 withFrame:CGRectMake(kPadding+10, (imageRect.origin.y+imageRect.size.height+kPadding), (_pageSize.width/2), 150) fontSize:72.0f];
    //Student's name
    CGRect studentTitleRect = [self addText:@"Walkerton District Secondary School"
                                  withFrame:CGRectMake(kPadding+10, (schoolTitleRect.origin.y+schoolTitleRect.size.height+kPadding), (_pageSize.width/2), 150) fontSize:68.0f];
    //Hours title
    CGRect hoursTitleRect = [self addText:@"Volunteer Work Completed"
                                withFrame:CGRectMake((kPadding+10), (studentTitleRect.origin.y+studentTitleRect.size.height+kPadding+60), 400, 200) fontSize:62.0f];
    
    ///////////////////
    //TABLE HEADINGS//
    /////////////////
    
    //Job Heading
    CGRect jobsHeadingRect = [self addText:@"Job Title"
                                 withFrame:CGRectMake((kPadding+130), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:62.0f];
    //Employer Heading
    CGRect employerHeadingRect = [self addText:@"Employer"
                                     withFrame:CGRectMake((jobsHeadingRect.origin.x + jobsHeadingRect.size.width + 160), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:58.0f];
    //Hours Heading
    CGRect hoursHeadingRect = [self addText:@"Hours"
                                  withFrame:CGRectMake((employerHeadingRect.origin.x + employerHeadingRect.size.width + 160), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:58.0f];
    //Date Heading
    CGRect dateHeadingRect = [self addText:@"Date"
                                 withFrame:CGRectMake((hoursHeadingRect.origin.x + hoursHeadingRect.size.width + 160), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:58.0f];
    //Phone Heading
    CGRect phoneHeadingRect = [self addText:@"Phone Number"
                                  withFrame:CGRectMake((dateHeadingRect.origin.x + dateHeadingRect.size.width + 160), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:58.0f];
    //Signature Heading
    CGRect signatureHeadingRect = [self addText:@"Signature"
                                      withFrame:CGRectMake((phoneHeadingRect.origin.x + phoneHeadingRect.size.width + 160), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+80), 100, 250) fontSize:58.0f];
    
    ///////////////////
    //TABLE CREATION//
    /////////////////
    
    //Top Line
    [self addLineWithFrame:CGRectMake((kPadding+100), jobsHeadingRect.origin.y-15, (_pageSize.width-200), 8)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Top Line - Inside
    [self addLineWithFrame:CGRectMake((kPadding+100), jobsHeadingRect.origin.y+jobsHeadingRect.size.height+15, (_pageSize.width-200), 5)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Left Line
    [self addLineWithFrame:CGRectMake((kPadding+100), jobsHeadingRect.origin.y+985, 8, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    
    //Right Line
    [self addLineWithFrame:CGRectMake((kPadding+100+_pageSize.width-208), jobsHeadingRect.origin.y+985, 8, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Bottom Line
    [self addLineWithFrame:CGRectMake((kPadding+100), (jobsHeadingRect.origin.y-15+2000), (_pageSize.width-200), 8)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    ///////////////////
    //Division Lines//
    /////////////////
    
    //Between Job Title and Employer
    [self addLineWithFrame:CGRectMake((jobsHeadingRect.origin.x+jobsHeadingRect.size.width+80), jobsHeadingRect.origin.y+985, 5, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Between Employer and Hours
    [self addLineWithFrame:CGRectMake((employerHeadingRect.origin.x+employerHeadingRect.size.width+80), jobsHeadingRect.origin.y+985, 5, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Between Hours and Date
    [self addLineWithFrame:CGRectMake((hoursHeadingRect.origin.x+hoursHeadingRect.size.width+80), jobsHeadingRect.origin.y+985, 5, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Between Date and Phone Number
    [self addLineWithFrame:CGRectMake((dateHeadingRect.origin.x+dateHeadingRect.size.width+80), jobsHeadingRect.origin.y+985, 5, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    //Between Phone Number and Signature
    [self addLineWithFrame:CGRectMake((phoneHeadingRect.origin.x+phoneHeadingRect.size.width+80), jobsHeadingRect.origin.y+985, 5, 2000)
                 withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    
    
    //CGRect imageRect = [self addImage:anImage atPoint:CGPointMake((_pageSize.width/2)-(anImage.size.width/2), headerDivider.origin.y + headerDivider.size.height + kPadding)];
    
    
    //////////////////
    //Fill out Form//
    ////////////////
    
    
    for (int i = 0; i < self.titlesArray.count; i++) {
        NSLog(@"This has ran %i", i);
        
        //Job Title
        CGRect completedTitle = [self addText:[self.titlesArray objectAtIndex:i]
                                    withFrame:CGRectMake((kPadding+130), (jobsHeadingRect.origin.y+jobsHeadingRect.size.height+kPadding+40+(120*i)), 100, 250) fontSize:38.0f];
        
        //Employers Name
        CGRect completedEmployer = [self addText:[self.nameArray objectAtIndex:i]
                                       withFrame:CGRectMake((jobsHeadingRect.origin.x + jobsHeadingRect.size.width + 120), (employerHeadingRect.origin.y+employerHeadingRect.size.height+kPadding+40+(120*i)), 100, 250) fontSize:38.0f];
        //Hours
        CGRect completedHours = [self addText:[self.hoursArray objectAtIndex:i]
                                    withFrame:CGRectMake((employerHeadingRect.origin.x + employerHeadingRect.size.width + 120), (hoursHeadingRect.origin.y+hoursHeadingRect.size.height+kPadding+40+(120*i)), 100, 250) fontSize:38.0f];
        
        //Date
        CGRect completedDate = [self addText:[self.dateArray objectAtIndex:i]
                                   withFrame:CGRectMake((hoursHeadingRect.origin.x + hoursHeadingRect.size.width + 120), (dateHeadingRect.origin.y+dateHeadingRect.size.height+kPadding+40+(120*i)), 100, 250) fontSize:38.0f];
        
        //Phone Number
        CGRect completedPhone = [self addText:[self.phoneArray objectAtIndex:i]
                                    withFrame:CGRectMake((dateHeadingRect.origin.x + dateHeadingRect.size.width + 120), (dateHeadingRect.origin.y+dateHeadingRect.size.height+kPadding+40+(120*i)), 100, 250) fontSize:38.0f];
        
        //header HELPR img
        UIImage *unflippedSig = [self.signatureArray objectAtIndex:i];
        UIImage *signatureImg = [UIImage imageWithCGImage:unflippedSig.CGImage scale:1.0 orientation:UIImageOrientationLeft];
        CGRect imageRect = [self addImage:signatureImg
                                  withFrame:CGRectMake((phoneHeadingRect.origin.x + phoneHeadingRect.size.width + 120), (hoursTitleRect.origin.y+hoursTitleRect.size.height+kPadding+160+(120*i)),250,100)];
             //Top Line - Inside
        [self addLineWithFrame:CGRectMake((kPadding+100), completedTitle.origin.y+completedTitle.size.height+15, (_pageSize.width-200), 5)
                     withColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    }
    
    
    
    [self finishPDF];
    NSString *selectedFile = @"HelprHours.pdf";
    [self showEmail:selectedFile];
    
}

- (void)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height {
    _pageSize = CGSizeMake(width, height);
    
    NSString *newPDFName = [NSString stringWithFormat:@"%@.pdf", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:newPDFName];
    
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
}

- (void)beginPDFPage {
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, _pageSize.width, _pageSize.height), nil);
}

- (void)finishPDF {
    UIGraphicsEndPDFContext();
}

- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
	CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
    
	float textWidth = frame.size.width;
    
    if (textWidth < stringSize.width)
        textWidth = stringSize.width;
    if (textWidth > _pageSize.width)
        textWidth = _pageSize.width - frame.origin.x;
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    return frame;
}

- (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    // this is the thickness of the line
    CGContextSetLineWidth(currentContext, frame.size.height);
    
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    return frame;
}

- (CGRect)addImage:(UIImage*)image withFrame:(CGRect)frame {
    CGRect imageFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [image drawInRect:imageFrame];
    
    return imageFrame;
}




///////////////
//Email Code//
/////////////

- (void)showEmail:(NSString*)file {
    
    NSString *emailTitle = @"Helpr";
    NSString *messageBody = @"Thanks for choosing Helpr, here is your time sheet";
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Determine the file name and extension
    NSArray *filepart = [file componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
