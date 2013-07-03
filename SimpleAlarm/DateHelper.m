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
    [formater setDateFormat:kDateFormatterYearMonthDayHourMinuteSecond];
    NSDate* date = [formater dateFromString:dateStr];
    [formater release];
    return date;
}

+ (NSDate *)dateUTCWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {
    
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

+ (NSDateComponents *)componentsWithDate:(NSDate *)date {
    NSInteger flag = NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flag fromDate:date];
    return components;
}

+ (NSDate *)dateWithComponenets:(NSDateComponents *)components {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:components];
    [gregorian release];
    return date;
}

+ (NSString *)decadeNumberFormat:(int)number {    
    return number < 10 ? [NSString stringWithFormat:@"0%d",number] : [NSString stringWithFormat:@"%d",number];
}
@end
