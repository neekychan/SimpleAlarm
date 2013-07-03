//
//  AddAlarmViewController.h
//  SimpleAlarm
//
//  Created by chan on 2/8/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseViewController.h"
#import "DateHelper.h"
#import "SimpleMenuView.h"

@class SettingViewCell;
@class DefaultNavigationBar;
@class AlarmRecord;



@interface AddAlarmViewController : BaseViewController <UIPickerViewDataSource,
                                                        UIPickerViewDelegate,
                                                        UITableViewDataSource,
                                                        UITableViewDelegate,
                                                        UITextViewDelegate,
                                                        SimpleMenuViewDelegate>
{
    NSArray *settingTiles;
    NSArray *settingIcons;
    NSArray *settingCustomTitle;
    NSArray *settingCustomIcons;
    NSArray *settingTypeTitle;
    NSArray *settingCustomRingTitle;
    UIButton *hiddenKeyBoardView;
    UITextView *tmpMessageTextView;
    BOOL isMessageTextViewEmpty;
    SettingViewCell *currentCell;
    DefaultNavigationBar *_customNavigationBar;
    AlarmRecord *alarmRecord;
    SimpleMenuView *valuePicker;
    
}

@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UITableView *settingTableView;
@property (retain, nonatomic) IBOutlet UITextView *messageTextView;
@property (retain, nonatomic) IBOutlet UIPickerView *timePicker;
@property (retain, nonatomic) AlarmRecord *setting;


- (void)returnBtnAction;
- (void)saveBtnAction;
- (id)initWithAlarmRecord:(AlarmRecord *)record;


@end
