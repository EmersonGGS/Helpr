//
//  OngoingTableViewController.h
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-10-28.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OngoingTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSMutableArray *hoursArray;
@property (strong, nonatomic) NSMutableArray *addressArray;
@property (strong, nonatomic) NSMutableArray *phoneArray;
@property (strong, nonatomic) NSMutableArray *notesArray;
@property (strong, nonatomic) NSMutableArray *objectIdArray;
@property(nonatomic,strong)NSMutableArray *contentArray;

@end
