//
//  CycleCell.h
//  SimpleAlarm
//
//  Created by Chan on 4/24/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCell : UITableViewCell {

}
@property (retain, nonatomic) IBOutlet UILabel *dayTitle;
@property (retain, nonatomic) IBOutlet UIImageView *tickIcon;
@property (retain, nonatomic) id delegate;
@property (assign, nonatomic) BOOL tick;

- (BOOL)isTick;

@end

