//
//  JobTableViewCell.m
//  Farm Fresh Simcoe
//
//  Created by Stewart Emerson on 10/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "JobTableViewCell.h"

@implementation JobTableViewCell

@synthesize titleLabel ;
@synthesize dateTimeLabel;
@synthesize timeLabel;
@synthesize hoursTimeLabel;
@synthesize addressLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end