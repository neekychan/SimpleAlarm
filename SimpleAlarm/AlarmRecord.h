//
//  AlarmRecord.h
//  SimpleAlarm
//
//  Created by chan on 2/5/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmRecord : NSObject
@property int ID;
@property int type;
@property (nonatomic,retain) NSString *cycle;
@property (nonatomic,retain) NSDate *time;
@property int rest_time;
@property (nonatomic,retain) NSString *message;
/*
 typedef struct {
 int ID;
 int type;
 NSString *cycle;
 NSDate *time;
 int rest_time;
 NSString *message;
 }AlarmRecord;
 */
@end
