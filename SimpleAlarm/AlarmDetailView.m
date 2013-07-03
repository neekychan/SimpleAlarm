//
//  AlarmDetailView.m
//  SimpleAlarm
//
//  Created by Chan on 5/6/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "AlarmDetailView.h"

@implementation AlarmDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setAlarmRecord:(AlarmRecord *)alarmRecord {
    
    if(_alarmRecord != alarmRecord){
        _alarmRecord = [alarmRecord retain];
    }

    switch(_alarmRecord.type) {
        case kAlarmRecordTypeWakeup:
            _alarmType.text = @"起床闹钟";
            break;
        case kAlarmRecordTypeAlarm:
            _alarmType.text = @"提醒闹钟";
            break;
        default:
            _alarmType.text = @"提醒闹钟";
            break;
    }

    NSDateComponents *comp = [DateHelper componentsWithDate:_alarmRecord.time];
    NSString *hour = [DateHelper decadeNumberFormat:comp.hour];
    NSString *mins = [DateHelper decadeNumberFormat:comp.minute];
    _alarmTime.text = [NSString stringWithFormat:@"%@:%@",hour,mins];

    _alarmMessage.text = _alarmRecord.message;

}



- (void)dealloc {
    [_countDown release];
    [_alarmIcon release];
    [_alarmType release];
    [_alarmTime release];
    [_alarmMessage release];
    [_alarmRecord release];
    [super dealloc];
}
@end
