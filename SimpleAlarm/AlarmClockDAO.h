//
//  AlarmClockDAO.h
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//
@class AlarmRecord;
@protocol AlarmClockDAO<NSObject>

-(void) addAlarmClock:(AlarmRecord *)alarmRecord;
-(void) deleteAlarmClock:(int)itemID;
-(void) updateAlarmClock:(AlarmRecord *)alarmRecord;
- (NSMutableArray *)allAlarmRecords;

@end