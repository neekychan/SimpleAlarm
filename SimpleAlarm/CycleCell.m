//
//  CycleCell.m
//  SimpleAlarm
//
//  Created by Chan on 4/24/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "CycleCell.h"

@implementation CycleCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self.tickIcon setHidden:YES];

    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

}

- (BOOL)isTick{
    return _tick;
}

- (void)setTick:(BOOL)tick{
    _tick = tick;
    if (tick) {
        [self.tickIcon setImage:[UIImage imageNamed:@"icon_tick"]];
    } else {
        [self.tickIcon setImage:[UIImage imageNamed:@"icon_tick_unselected"]];
    }
}

- (void)dealloc {
    [_dayTitle release];
    [_tickIcon release];

    [super dealloc];
}
@end
