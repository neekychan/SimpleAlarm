//
//  AlarmRecord.m
//  SimpleAlarm
//
//  Created by chan on 2/5/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "AlarmRecord.h"

@implementation AlarmRecord
@synthesize ID;
@synthesize type;
@synthesize time;
@synthesize cycle;
@synthesize restTime;
@synthesize message;
@synthesize ringType;
@synthesize status;
@synthesize image;

- (id)init {
    self = [super init];
    if(self) {
        self.type        = kAlarmRecordTypeAlarm;
        self.time        = [NSDate date];
        self.cycle       = @"1,2,3,4,5";
        self.restTime    = 0;
        self.message     = @"No Message";
        self.ringType    = kAlarmRecordRingTypeDefault;
        self.status      = YES;
        self.image       = Nil;
    }
    return  self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nID:%d,\nType:%d,\nCycle:%@,\nTime:%@,\nRest_Time:%d,\nMessage:%@,\nringType:%d,\nstatus:%@",
            ID,
            type,
            cycle,
            [time description],
            restTime,
            message,
            ringType,
            status ? @"YES" : @"NO"
            ];
}

- (void)dealloc{
    [time release];
    [cycle release];
    [message release];
    [image release];
    [super dealloc];
}
@end
