//
//  SettingViewCell.m
//  SimpleAlarm
//
//  Created by chan on 2/10/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "SettingViewCell.h"


@implementation SettingViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



- (void)layoutSubviews{
    [super layoutSubviews];
}




- (void)setTextViewMode:(BOOL)state{
    
    if(state == YES){
        
        [self.messageTextView setFrame:CGRectMake(6, 6, 280, 220)];
        [self.messageTextView setText:@"如:起床以后要做些什么?"];
        [self.messageTextView setTextColor:[UIColor grayColor]];
        
        [self.iConImageView removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.contentLabel removeFromSuperview];
        [self.extendIconImageView removeFromSuperview];
        [self.messageTextView setHidden:NO];
   
        
    } else {
        [self.iConImageView setHidden:NO];
        [self.titleLabel setHidden:NO];
        [self.contentLabel setHidden:NO];
        [self.messageTextView setHidden:YES];
        [self.extendIconImageView setHidden:NO];
    }
}

- (void)setDelegate:(id<UITextViewDelegate>)del {
    [self.messageTextView setDelegate:del];
}

- (void)dealloc {
    [_iConImageView release];
    [_titleLabel release];
    [_contentLabel release];
    [_messageTextView release];
    [_extendIconImageView release];
    [super dealloc];
}
@end
