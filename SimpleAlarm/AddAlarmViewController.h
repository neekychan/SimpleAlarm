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

@class SettingViewCell;
@class DefaultNavigationBar;
@class AlarmRecord;



@interface AddAlarmViewController : BaseViewController <UIPickerViewDataSource,
                                                        UIPickerViewDelegate,
                                                        UITableViewDataSource,
                                                        UITableViewDelegate,
                                                        UITextViewDelegate>
{
    NSArray *settingTiles;
    NSArray *settingIcons;
    UIButton *hiddenKeyBoardView;
    UITextView *tmpMessageTextView;
    BOOL isMessageTextViewEmpty;
    SettingViewCell *currentCell;
    DefaultNavigationBar *_customNavigationBar;
    AlarmRecord *alarmRecord;
}

@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UITableView *settingTableView;
@property (retain, nonatomic) IBOutlet UITextView *messageTextView;
@property (retain, nonatomic) IBOutlet UIPickerView *timePicker;
@property (retain, nonatomic) AlarmRecord *setting;


@property (retain, nonatomic) IBOutlet UIView *resttimePickerView;
- (IBAction)fiveMinsBtnAction:(id)sender;

- (void)returnBtnAction;
- (void)saveBtnAction;
- (id)initWithAlarmRecord:(AlarmRecord *)record;

- (IBAction)fifteenMinsBtnAction:(id)sender;
- (IBAction)twentyMinsBtnAction:(id)sender;


@end
