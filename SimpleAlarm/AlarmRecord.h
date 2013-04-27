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
@property (copy,nonatomic) NSString *cycle;
@property (nonatomic,retain) NSDate *time;
@property int restTime;
@property (copy,nonatomic) NSString *message;

@end
