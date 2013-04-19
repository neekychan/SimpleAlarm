//
//  SettingViewCell.h
//  SimpleAlarm
//
//  Created by chan on 2/10/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultDelegate.h"

@interface SettingViewCell : UITableViewCell <UITextViewDelegate>{
    BOOL isEmpty;
    UIButton *hiddenKeyBoardView;
}
@property (retain, nonatomic) IBOutlet UIImageView *iConImageView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UITextView *messageTextView;
@property (retain, nonatomic) IBOutlet UIImageView *extendIconImageView;
@property (assign, nonatomic) id<UITextViewDelegate> delegate;

- (void) setTextViewMode:(BOOL)state;


@end
