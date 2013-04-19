//
//  DefaultNavigationBar.h
//  SimpleAlarm
//
//  Created by chan on 3/12/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultNavigationBar : UINavigationBar{
    UINavigationItem *_navigationItem;
}

@property (nonatomic, assign) UIViewController *controller;
@property (nonatomic, retain) NSString *title;

- (id)initWithController:(UIViewController *)controller frame:(CGRect)frame title:(NSString *)title;
- (void)addBackButton:(NSString *)title action:(SEL)selector;
- (void)addForwardButton:(NSString *)title action:(SEL)selector;
- (void)addLeftButton:(NSString *)title action:(SEL)selector;

@end
