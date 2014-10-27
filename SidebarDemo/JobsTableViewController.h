//
//  JobsTableViewController.h
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSMutableArray *hoursArray;
@property (strong, nonatomic) NSMutableArray *addressArray;
@property (strong, nonatomic) NSMutableArray *notesArray;
@property (strong, nonatomic) NSMutableArray *objectIdArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@end
