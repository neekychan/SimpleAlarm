//
//  AlarmListCell.m
//  SimpleAlarm
//
//  Created by chan on 2/3/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "AlarmListCell.h"

@implementation AlarmListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithAlarmRecord:(AlarmRecord *)record{
    
    
    NSInteger days = [self intervalWithDates:[NSDate date] another:record.time];
    [_day setText:[self dayTipByDays:days]];
    [_countdown setText:[self countDownTipByDates:[NSDate date] endDate:record.time]];
    
}

- (BOOL)isToday:(NSDate *)date{
    
    NSDate *now = [NSDate date];
    
    if([self intervalWithDates:now another:date] == 0){
        return YES;
    }
    
    return NO;
}

- (NSInteger)intervalWithDates:(NSDate *)date another:(NSDate *)another{
    
    NSInteger days = -1;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
    | NSMinuteCalendarUnit | NSSecondCalendarUnit;
   
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger monthOfDateOne = [comps month];
    comps = [calendar components:unitFlags fromDate:another];
    NSInteger monthOfDateTwo = [comps month];
    
    if(monthOfDateOne == monthOfDateTwo){
        //同月份的情况下比较日期
        NSInteger dayOfDateTwo = [comps day];
        comps = [calendar components:unitFlags fromDate:date];
        NSInteger dayOfDateOne = [comps day];
        
        days = dayOfDateTwo - dayOfDateOne;
    } else {
        //不同月份的情况下比较相差天数
        unitFlags = NSDayCalendarUnit;
        comps = [calendar components:unitFlags fromDate:date  toDate:another  options:0];
        days = [comps day];
    }

    [calendar release];
    
    return days;
}



- (NSString *)dayTipByDays:(NSInteger)_days{
    
    NSString *tip = @"";
    
    
    switch (_days) {
        case 0:
            tip = COUNTDOWN_TIP_TODAY;
            break;
        case 1:
            tip = COUNTDOWN_TIP_TOMORROW;
            break;
            
        default:
            
            tip = [[[NSString alloc]initWithFormat:@"%d天后",(int)_days] autorelease];
            break;
    }
    
    return tip;
}

- (NSString *)countDownTipByDates:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSTimeInterval interval = [endDate timeIntervalSinceDate:startDate];
    
    NSInteger hours = interval / 3600;
    NSInteger mins = ((int)interval % 3600) / 60;
    
    NSString *tip = @"";
    
    if(hours == 0){
        tip = [[NSString alloc] initWithFormat:@"%d分后响铃",mins];
    } else if(hours < 12){
        tip = [[NSString alloc] initWithFormat:@"0%d时%d分后响铃",hours,mins];
    } else {
        tip = [[NSString alloc] initWithFormat:@"%d时%d分后响铃",hours,mins];
    }
    
    
    return [tip autorelease];
}

- (void)dealloc {
    [_icon release];
    [_time release];
    [_countdown release];
    [_day release];
    [super dealloc];
}
@end
