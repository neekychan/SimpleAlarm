//
//  AlarmDetailView.h
//  SimpleAlarm
//
//  Created by Chan on 5/6/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmRecord.h"
#import "DateHelper.h"

@interface AlarmDetailView : UIView
@property (retain, nonatomic) IBOutlet UILabel *countDown;
@property (retain, nonatomic) IBOutlet UIImageView *alarmIcon;
@property (retain, nonatomic) IBOutlet UILabel *alarmType;
@property (retain, nonatomic) IBOutlet UILabel *alarmTime;
@property (retain, nonatomic) IBOutlet UITextView *alarmMessage;
@property (retain, nonatomic) AlarmRecord *alarmRecord;

@end
