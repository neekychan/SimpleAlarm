//
//  AlarmClockImpl.m
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "SimpleAlarmDataBase.h"

@implementation SimpleAlarmDataBase

@synthesize allAlarmRecords;

static SimpleAlarmDataBase *simpleAlarmDataBase = Nil;

- (void)addAlarmClock:(AlarmRecord *)alarmRecord{//type,cycle,time,rest_time,message
    
    [db executeUpdate:DB_SQL_ALARMCLOCKDAO_ADD_ITEM,[NSNumber numberWithInt:alarmRecord.type],alarmRecord.cycle,alarmRecord.time,[NSNumber numberWithInt:alarmRecord.restTime],alarmRecord.message,[NSNumber numberWithInt:alarmRecord.ringType],[NSNumber numberWithBool:alarmRecord.status],alarmRecord.image];
    FMResultSet *result = [db executeQuery:DB_SQL_ALARMCLOCKDAO_SELECT_ALL];
    while([result next]){
        NSLog(@"Type:%d,Cycle:%@,Time:%@,Rest_Time:%d,Message:%@,ringType:%d,status:%c",
              [result intForColumn:@"type"],
              [result stringForColumn:@"cycle"],
              [[result dateForColumn:@"time"] description],
              [result intForColumn:@"rest_time"],
              [result stringForColumn:@"message"],
              [result intForColumn:@"ring"],
              [result boolForColumn:@"status"]
              );
    }
    
    [result close];

}

- (void)deleteAlarmClock:(int)itemID{
    [db executeUpdate:DB_SQL_ALARMCLOCKDAO_DELETE_ITEM,[NSNumber numberWithInt:itemID]];
    
}

- (void)updateAlarmClock:(AlarmRecord *)alarmRecord{
    [db executeUpdate:DB_SQL_ALARMCLOCKDAO_UPDATE_ITEM,[NSNumber numberWithInt:alarmRecord.type],alarmRecord.cycle,alarmRecord.time,[NSNumber numberWithInt:alarmRecord.restTime],alarmRecord.message,[NSNumber numberWithInt:alarmRecord.ringType],[NSNumber numberWithBool:alarmRecord.status],alarmRecord.image,[NSNumber numberWithInt:alarmRecord.ID]];
}

- (NSMutableArray *)allAlarmRecords{
    
    FMResultSet *result = [db executeQuery:DB_SQL_ALARMCLOCKDAO_SELECT_ALL];
    allAlarmRecords = [[NSMutableArray alloc] initWithCapacity:20];
    while([result next]){
        
        AlarmRecord *record = [self convertResultToAlarmRecord:result];
        
        //NSValue *miValue = [NSValue valueWithBytes:&record objCType:@encode(AlarmRecord)]; // encode using the type name
        [allAlarmRecords addObject:record];
        
        NSLog(@"%@",[record description]);

    }
    return allAlarmRecords;
}

- (AlarmRecord *)convertResultToAlarmRecord:(FMResultSet *)result {
    
    AlarmRecord *record = [[[AlarmRecord alloc] init] autorelease];
    record.ID       = [result intForColumn:@"id"];
    record.type     = [result intForColumn:@"type"];
    record.cycle    = [result stringForColumn:@"cycle"];
    record.time     = [result dateForColumn:@"time"];
    record.restTime = [result intForColumn:@"rest_time"];
    record.message  = [result stringForColumn:@"message"];
    record.ringType = [result intForColumn:@"ring"];
    record.status   = [result boolForColumn:@"status"];
    record.image    = [result dataForColumn:@"image"];
    return record;
}

+ (SimpleAlarmDataBase *)shareDataBase{
    @synchronized(self){
        if(simpleAlarmDataBase == Nil){
            simpleAlarmDataBase = [[SimpleAlarmDataBase alloc] init];
        }
        return simpleAlarmDataBase;
    }
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if(simpleAlarmDataBase == Nil){
            simpleAlarmDataBase = [super allocWithZone:zone];
            return simpleAlarmDataBase;
        }
    }
    
    return Nil;
}

- (void)dealloc{
    [super dealloc];
    [db close];
    [allAlarmRecords release];
    simpleAlarmDataBase = Nil;
}

- (id)init{
    self = [super init];
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"database.sqlite"];
        
        //[[NSFileManager defaultManager] removeItemAtPath:dbPath error:Nil];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
            db = [[FMDatabase databaseWithPath:dbPath] retain];
            if(![db open]){
                NSLog(@"无法打开数据库");
            } else {
                [db executeUpdate:DB_SQL_CREATE_TABLE];
                NSLog(@"创建数据库成功");
                //[db executeUpdate:@"CREATE TABLE User (Name text,Age integer)"];
            }
            
        } else {
            db = [[FMDatabase databaseWithPath:dbPath] retain];
            [db open];
        }
        
        
        
    }
    
    return self;
}
@end
