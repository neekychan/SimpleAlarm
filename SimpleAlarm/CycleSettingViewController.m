//
//  CycleSettingViewController.m
//  SimpleAlarm
//
//  Created by chan on 3/12/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "CycleSettingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CycleSettingViewController ()

@end

@implementation CycleSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setTitle:@"选择周期"];
    [self.navigationBar addBackButton:@"返回" action:@selector(backButtonAction)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark -navigationbar delegate

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload{
    [self setSelectLineImageView:nil];
}
- (void)dealloc
{
    [_selectLineImageView release];
    [super dealloc];
}

- (IBAction)workDayBtnAction:(id)sender {
    [self selectLineMove:1];
}

- (IBAction)weekendBtnAction:(id)sender {
    [self selectLineMove:2];
}
- (IBAction)customBtnAction:(id)sender {
    [self selectLineMove:3];
}

- (void)selectLineMove:(int)column {
    [UIView beginAnimations:Nil context:Nil];
    [UIView setAnimationDuration:0.2];

    CGPoint cPoint = CGPointZero;
    switch (column) {
        case 1:
            cPoint = CGPointMake(58.0f, 90.0f);
            break;
        case 2:
            cPoint = CGPointMake(160.0f, 90.0f);
            break;
        case 3:
            cPoint = CGPointMake(263.0f, 90.0f);
            break;
            
        default:
            break;
    }
    
    _selectLineImageView.center = cPoint;
    [UIView commitAnimations];
    
}

@end
