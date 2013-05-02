//
//  CycleSettingViewController.m
//  SimpleAlarm
//
//  Created by chan on 3/12/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "CycleSettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#define TABLEVIEW_NUMBER_OF_ROWS 7
#define TABLEVIEW_HEIGHT_FOR_ROW 45

@interface CycleSettingViewController ()

@end

@implementation CycleSettingViewController

static NSString *CellIdentifier = @"cycleCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        cycleTile = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];
        daySelects = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"1",@"2",@"2",@"4",@"4",@"5",@"5", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setTitle:@"选择周期"];
    [self.navigationBar addBackButton:@"返回" action:@selector(backButtonAction)];
    
    [self.cycleTableView setDelegate:self];
    [self.cycleTableView setDataSource:self];
    
    tableViewHeightForRow = iPhone5 ? 60 : 47;
    
    UINib *nib = [UINib nibWithNibName:@"CycleCell" bundle:nil];
    [self.cycleTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark -navigationbar delegate

- (void)backButtonAction{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"cycleSelected" object:[daySelects retain]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableview delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CycleCell *cell = (CycleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == Nil) {
        cell = [[[CycleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        CGRect rect = cell.bounds;
        rect.size.height = tableViewHeightForRow;
        [cell setBounds:rect];
        //根据屏幕尺寸适配单元格高度
        
    }
    
    CGPoint point = [cell.dayTitle center];
    point.y = tableViewHeightForRow / 2;
    CGPoint point2 = [cell.tickIcon center];
    point2.y = tableViewHeightForRow / 2;
    [cell.dayTitle setCenter:point];
    [cell.tickIcon setCenter:point2];
    
    [cell setBackgroundColor:UIColor.whiteColor];
    [cell.dayTitle setText:[cycleTile objectAtIndex:indexPath.row]];
    [cell setTick:[daySelects objectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]] != Nil ? YES : NO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CycleCell *cell = (CycleCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *key = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    
    if(![cell isTick]) {
        [cell setTick:YES];
        [daySelects setObject:key forKey:key];
    } else {
        [cell setTick:NO];
        [daySelects removeObjectForKey:key];
    }
    
    [self selectLineMove:3];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewHeightForRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TABLEVIEW_NUMBER_OF_ROWS;
}




- (IBAction)workDayBtnAction:(id)sender {
    
    [daySelects removeAllObjects];
    
    for(int i = 1;i <=5;i++) {
        NSString *key = [NSString stringWithFormat:@"%d",i];
        [daySelects setValue:key forKey:key];
    }
    
    [self selectLineMove:1];
}

- (IBAction)weekendBtnAction:(id)sender {
    
    [daySelects removeAllObjects];
    [daySelects setValue:[NSString stringWithFormat:@"%d",6] forKey:[NSString stringWithFormat:@"%d",6]];
    [daySelects setValue:[NSString stringWithFormat:@"%d",7] forKey:[NSString stringWithFormat:@"%d",7]];
    
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
    
    self.selectLineImageView.center = cPoint;
    [UIView commitAnimations];
    [self.cycleTableView reloadData];
}

- (void)viewDidUnload{
    [self setCycleTableView:nil];
    [self setSelectLineImageView:nil];
}
- (void)dealloc
{
    [_selectLineImageView release];
    [_cycleTableView release];
    [cycleTile release];
    [daySelects release];
    [super dealloc];
}

@end
