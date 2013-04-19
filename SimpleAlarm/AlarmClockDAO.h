//
//  AlarmClockDAO.h
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

@protocol AlarmClockDAO<NSObject>

-(void) addAlarmClock:(NSDictionary *)setting;
-(void) deleteAlarmClock:(int)itemID;
-(void) updateAlarmClock:(NSDictionary *)setting;
- (NSMutableArray *)allAlarmRecords;

@end