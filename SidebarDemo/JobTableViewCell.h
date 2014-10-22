//
//  JobTableViewCell.h
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end
