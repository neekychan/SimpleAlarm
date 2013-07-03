//
//  AlarmClockImpl.h
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "statics.h"
#import "AlarmClockDAO.h"
#import "AlarmRecord.h"
#import "FMDatabase.h"

@interface SimpleAlarmDataBase : NSObject <AlarmClockDAO>{
    FMDatabase *db;
}

@property (retain,nonatomic) NSMutableArray *allAlarmRecords;

+ (SimpleAlarmDataBase *)shareDataBase;


@end
