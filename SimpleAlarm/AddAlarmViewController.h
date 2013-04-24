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

@class SettingViewCell;
@class DefaultNavigationBar;



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
    //CycleSettingViewController *cycleSettingView;
}

@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UITableView *settingTableView;
@property (retain, nonatomic) IBOutlet UITextView *messageTextView;
@property (retain, nonatomic) IBOutlet UIPickerView *timePicker;
@property (retain, nonatomic) NSDictionary *setting;


- (void)returnBtnAction;
- (void)saveBtnAction;
- (id)initWithSetting:(NSDictionary *)settings;

@end
