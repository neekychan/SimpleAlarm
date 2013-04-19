//
//  AlarmListCell.h
//  SimpleAlarm
//
//  Created by chan on 2/3/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statics.h"
@interface AlarmListCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *icon;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *countdown;
@property (retain, nonatomic) IBOutlet UILabel *day;

- (void) initWithAlarmRecord:(AlarmRecord *)record;

@end
