//
//  DateHelper.m
//  SimpleAlarm
//
//  Created by chan on 4/23/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {

    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",year,month,day,hour,minute,second];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formater setDateFormat:kDateFormatterYearMonthDayHourMinuteSecond];
    NSDate* date = [formater dateFromString:dateStr];
    [formater release];
    return date;
}

+ (NSString *)stringFromDateWithFormatter:(NSDate *)date formatter:(NSDateFormatter *)formatter {
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
@end
