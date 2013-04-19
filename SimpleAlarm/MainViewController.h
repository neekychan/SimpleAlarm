//
//  MainViewController.h
//  SimpleAlarm
//
//  Created by chan on 1/30/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statics.h"
#import "AlarmListCell.h"
#import "AddAlarmViewController.h"
#import "BaseViewController.h"

@interface MainViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>{
    SimpleAlarmDataBase *db;
    NSMutableArray *alarmRecords;
}


@property (retain, nonatomic) IBOutlet UIView *alarmListItemView;
@property (retain, nonatomic) IBOutlet UITableView *alarmListView;


- (void)addAlarmAction;
- (IBAction)testBtn:(id)sender;


@end
