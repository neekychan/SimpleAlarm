//
//  AlarmRecord.h
//  SimpleAlarm
//
//  Created by chan on 2/5/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kAlarmRecordTypeWakeup  0
#define kAlarmRecordTypeAlarm   1

#define kAlarmRecordRingTypeDefault 0



@interface AlarmRecord : NSObject
@property int ID;
@property int type;
@property (retain,nonatomic) NSString *cycle;
@property (nonatomic,retain) NSDate *time;
@property int restTime;
@property (copy,nonatomic) NSString *message;
@property int ringType;
@property BOOL status;
@property (retain, nonatomic) NSData *image;

@end
