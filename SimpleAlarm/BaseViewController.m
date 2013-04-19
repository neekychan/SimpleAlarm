//
//  BaseViewController.m
//  SimpleAlarm
//
//  Created by chan on 4/10/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _navigationBar = [[DefaultNavigationBar alloc] initWithController:self frame:CGRectMake(0, 0, 320, 43) title:@""];
    [self.view addSubview:_navigationBar];

}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.navigationBar setTitle:title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (void)dealloc{
    [super dealloc];
}

@end
