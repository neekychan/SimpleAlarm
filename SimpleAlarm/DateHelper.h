//
//  DateHelper.h
//  SimpleAlarm
//
//  Created by chan on 4/23/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDateFormatterYearMonthDayHourMinuteSecond @"yyyy-MM-dd HH:mm:ss"
#define kDateFormatterYearMonthDay @"yyyy-MM-dd"
#define kDateFormatterHourMinuteSecond @"HH:mm:ss"

@interface DateHelper : NSObject


+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;
+ (NSDate *)dateUTCWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;
+ (NSString *)stringFromDateWithFormatter:(NSDate *)date formatter:(NSDateFormatter *)formatter;
+ (NSDateComponents *)componentsWithDate:(NSDate *)date;
+ (NSString *)decadeNumberFormat:(int)number;

@end
