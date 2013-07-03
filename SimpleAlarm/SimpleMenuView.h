//
//  SimpleMenuView.h
//  SimpleAlarm
//
//  Created by Chan on 5/8/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleMenuCell.h"
#import "statics.h"

@class SimpleMenuView;

@protocol SimpleMenuViewDelegate <NSObject>
- (void)simpleMenuView:(SimpleMenuView *)view itemSelected:(NSInteger)itemId;
@end

@interface SimpleMenuView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) id delegate;
@property int targetId;

- (id)initWithMenuTitle:(NSArray *)titles;

@end

