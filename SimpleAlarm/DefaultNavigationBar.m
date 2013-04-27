//
//  DefaultNavigationBar.m
//  SimpleAlarm
//
//  Created by chan on 3/12/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "DefaultNavigationBar.h"

@implementation DefaultNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithController:(UIViewController *)ctr frame:(CGRect)frame title:(NSString *)t{
    
    self = [super initWithFrame:frame];
    if (self) {
        _navigationItem = [[UINavigationItem alloc] init];
        [self pushNavigationItem:_navigationItem animated:NO];
        
        [self setTitle:t];
        self.controller = ctr;
        self.controller.navigationController.navigationBar.hidden = YES;
        
        UIImage *image = [UIImage imageNamed:@"navigationbar"];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        [backgroundImageView release];
    }
    
    return self;
}

- (void)addBackButton:(NSString *)title action:(SEL)selector{
    

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 52, 32);
    [backButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [backButton.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [backButton.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton addTarget:self.controller action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *upImage = [UIImage imageNamed:@"navi_button_back_up"];
    UIImage *downImage = [UIImage imageNamed:@"navi_button_back_down"];
    [backButton setBackgroundImage:upImage forState:UIControlStateNormal];
    [backButton setBackgroundImage:downImage forState:UIControlStateHighlighted];


    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    _navigationItem.leftBarButtonItem = backBarButton;

    [backBarButton release];
}


- (void)addForwardButton:(NSString *)title action:(SEL)selector{

    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(0, 0, 52, 32);
    [forwardButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [forwardButton.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [forwardButton.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [forwardButton setTitle:title forState:UIControlStateNormal];
    [forwardButton addTarget:self.controller action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *upImage = [UIImage imageNamed:@"navi_button_forward_up"];
    UIImage *downImage = [UIImage imageNamed:@"navi_button_forward_down"];
    [forwardButton setBackgroundImage:upImage forState:UIControlStateNormal];
    [forwardButton setBackgroundImage:downImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem *forwardBarButton = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    
    _navigationItem.rightBarButtonItem = forwardBarButton;
    
    [forwardBarButton release];
}


- (void)addLeftButton:(NSString *)title action:(SEL)selector{
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 52, 32);
    [leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [leftButton.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [leftButton.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton addTarget:self.controller action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *upImage = [UIImage imageNamed:@"navi_button_forward_up"];
    UIImage *downImage = [UIImage imageNamed:@"navi_button_forward_down"];
    [leftButton setBackgroundImage:upImage forState:UIControlStateNormal];
    [leftButton setBackgroundImage:downImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    _navigationItem.leftBarButtonItem = leftBarButton;
    
    [leftBarButton release];
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
    [titleLabel setText:_title];
    [titleLabel setShadowColor:[UIColor darkGrayColor]];
    [titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [titleLabel setFont:[UIFont systemFontOfSize:22.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    
    [_navigationItem setTitleView:titleLabel];
    [titleLabel release];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc{
    
    //[_navigationItem release];
    NSLog(@"%d",[_navigationItem retainCount]);
    [super dealloc];
}


@end
