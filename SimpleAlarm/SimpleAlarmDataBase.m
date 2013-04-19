//
//  AlarmClockImpl.m
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "SimpleAlarmDataBase.h"

@implementation SimpleAlarmDataBase

static SimpleAlarmDataBase *simpleAlarmDataBase = Nil;

- (void)addAlarmClock:(NSDictionary *)setting{//type,cycle,time,rest_time,message
    
    NSDate *date = (NSDate *)[setting objectForKey:DB_RECORD_SETTING_DATE];
    
    [db executeUpdate:@"INSERT INTO SIMPLEALARM (type,cycle,time,rest_time,message) VALUES(?,?,?,?,?)",[NSNumber numberWithInt:1],@"1,2,3,4,5",date,[NSNumber numberWithInt:15],@"No Message"];
    //[db executeUpdate:@"INSERT INTO User (Name,Age) VALUES (?,?)",@"张三",[NSNumber numberWithInt:20]];
    FMResultSet *result = [db executeQuery:@"SELECT * FROM SIMPLEALARM"];
    //FMResultSet *result = [db executeQuery:@"SELECT * FROM User"];
    while([result next]){
        NSLog(@"Type:%d,Cycle:%@,Time:%@,Rest_Time:%d,Message:%@",[result intForColumn:@"type"],[result stringForColumn:@"cycle"],[[result dateForColumn:@"time"] description],[result intForColumn:@"rest_time"],[result stringForColumn:@"message"]);
        //NSLog(@"%@ %@",[result stringForColumn:@"Name"],[result stringForColumn:@"Age"]);
    }
    
    
    [result close];
}
- (void)deleteAlarmClock:(int)itemID{
    
}
- (void)updateAlarmClock:(NSDictionary *)setting{
    
}

- (NSMutableArray *)allAlarmRecords{
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM SIMPLEALARM"];
    NSMutableArray *alarms = [[NSMutableArray alloc] initWithCapacity:20];
    
    while([result next]){
        
        AlarmRecord *record = [AlarmRecord alloc];
        record.ID = [result intForColumn:@"id"];
        record.type = [result intForColumn:@"type"];
        record.cycle = [result stringForColumn:@"cycle"];
        record.time = [result dateForColumn:@"time"];
        record.rest_time = [result intForColumn:@"rest_time"];
        record.message = [result stringForColumn:@"message"];
        
        //NSValue *miValue = [NSValue valueWithBytes:&record objCType:@encode(AlarmRecord)]; // encode using the type name
        [alarms addObject:record];
        
        NSLog(@"Type:%d,Cycle:%@,Time:%@,Rest_Time:%d,Message:%@",
              [result intForColumn:@"type"],
              [result stringForColumn:@"cycle"],
              [[result dateForColumn:@"time"] description],
              [result intForColumn:@"rest_time"],
              [result stringForColumn:@"message"]
              );

    }
    
    return alarms;
}

+ (SimpleAlarmDataBase *)shareSimpleAlarmDataBase{
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
