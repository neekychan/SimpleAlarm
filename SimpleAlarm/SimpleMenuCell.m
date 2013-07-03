//
//  SimpleMenuCell.m
//  SimpleAlarm
//
//  Created by Chan on 5/8/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "SimpleMenuCell.h"

@implementation SimpleMenuCell

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
    if(selected) {
        //self.contentView.backgroundColor = [UIColor colorWithRed:112 green:194 blue:246 alpha:1];
        //[self.menuTitle setTextColor:[UIColor whiteColor]];
    } else {
        //self.selectedBackgroundView = [[[UIView alloc] initWithFrame:self.frame] autorelease];
        //self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        //[self.menuTitle setTextColor:[UIColor darkGrayColor]];
    }
   
}

- (void)dealloc {
    [_menuTitle release];
    [super dealloc];
}
@end
