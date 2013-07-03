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
    
    self.record = record;
    
    //新的显示逻辑
    NSDateComponents *dateComp = [DateHelper componentsWithDate:record.time];
    [_time setText:[NSString stringWithFormat:@"%@:%@",[DateHelper decadeNumberFormat:dateComp.hour],[DateHelper decadeNumberFormat:dateComp.minute]]];
    
    NSInteger week = [[DateHelper componentsWithDate:[NSDate date]] weekday];
    NSInteger interval = [self intervalWithWeeks:week cycleWeek:record.cycle];

    _day.text = record.status == YES ? [self formatIntervalOfWeeks:interval]:@"暂停";
    [_countdown setText:[self countDownTipWithDate:record.time afterDays:interval]];
}

- (BOOL)isToday:(NSDate *)date{
    
    NSDate *now = [NSDate date];
    
    if([self intervalWithDates:now another:date] == 0){
        return YES;
    }
    
    return NO;
}


- (NSString *)formatIntervalOfWeeks:(NSInteger)interval {
    if (interval == 0)
        return @"今天";
    
    if(interval == -1)
        return @"过期";
    
    if (interval == 1) {
        return @"明天";
    }
    
    if(interval == 2)
        return @"后天";
    
    if(interval == 7)
        return @"下周";
    
    return [NSString stringWithFormat:@"%d天后",interval];
}

- (NSInteger)intervalWithWeeks:(NSInteger)dateWeek cycleWeek:(NSString *)cycle {
    
    dateWeek = dateWeek == 7 ? 1 :dateWeek - 1;
    
    NSArray *cycleWeek = [cycle componentsSeparatedByString:@","];
    
    if([cycleWeek count] == 0)
        return -1;
  
    //将周期里最先也最迟的日期取出来

    NSInteger theSmallOne = [(NSString *)[cycleWeek objectAtIndex:0] intValue];
    NSInteger theBigOne = [(NSString *)[cycleWeek lastObject] intValue];
    
    
    
    

    for(int i = 0;i < [cycleWeek count];i++) {
        
        NSInteger week = [(NSString *)[cycleWeek objectAtIndex:i] intValue];
        
        if(dateWeek > theBigOne) {
            return 7 - dateWeek + theSmallOne;
        }
        
        //当同一天的情况时
        if (dateWeek == week) {
            
            NSDateComponents *recordComps = [DateHelper componentsWithDate:self.record.time];
            NSDateComponents *newComps = [DateHelper componentsWithDate:[NSDate date]];
            
            [newComps setHour:recordComps.hour];
            [newComps setMinute:recordComps.minute];
            [newComps setSecond:recordComps.second];
            
            NSDate *newDate = [DateHelper dateWithComponenets:newComps];
            
            if([newDate compare:[NSDate date]] == NSOrderedAscending)
                continue;
            
            return 0;
        }
        
        //当比当前日期细时
        if(dateWeek < week) {
            return week - dateWeek;
        }            
    }
    
    return -1;
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
    } else if(hours < 10){
        tip = [[NSString alloc] initWithFormat:@"0%d时%d分后响铃",hours,mins];
    } else {
        tip = [[NSString alloc] initWithFormat:@"%d时%d分后响铃",hours,mins];
    }
    
    
    return [tip autorelease];
}

- (NSString *)countDownTipWithDate:(NSDate *)date afterDays:(NSInteger)days {
    
    NSDateComponents *recordComps = [DateHelper componentsWithDate:date];
    NSDateComponents *newComps = [DateHelper componentsWithDate:[NSDate dateWithTimeIntervalSinceNow:(days * 24 * 3600)]];
    
    [newComps setHour:recordComps.hour];
    [newComps setMinute:recordComps.minute];
    [newComps setSecond:recordComps.second];
    
    NSDate *newDate = [DateHelper dateWithComponenets:newComps];
    
    return [self countDownTipByDates:[NSDate date] endDate:newDate];
}

- (void)dealloc {
    [_icon release];
    [_time release];
    [_countdown release];
    [_day release];
    [super dealloc];
}
@end
