//
//  CycleSettingViewController.h
//  SimpleAlarm
//
//  Created by chan on 3/12/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statics.h"
#import "BaseViewController.h"

@interface CycleSettingViewController : BaseViewController{

}

- (IBAction)workDayBtnAction:(id)sender;
- (IBAction)weekendBtnAction:(id)sender;
- (IBAction)customBtnAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *selectLineImageView;


@end
