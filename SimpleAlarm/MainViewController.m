//
//  MainViewController.m
//  SimpleAlarm
//
//  Created by chan on 1/30/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    [self.navigationBar setTitle:@"添加"];
    [self.navigationBar addForwardButton:@"添加" action:@selector(addAlarmAction)];
    
    db = [[SimpleAlarmDataBase shareSimpleAlarmDataBase] retain];
    [_alarmListView setDelegate:self];
    [_alarmListView setDataSource:self];
    [_alarmListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//隐藏分割线
    [_alarmListView setShowsVerticalScrollIndicator:NO];
    alarmRecords = [db allAlarmRecords];
    NSLog(@"AlarmRecords retianCount:%d",[alarmRecords retainCount]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addAlarmAction {
    //[db addAlarmClock:Nil];
    AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithNibName:@"AddAlarmViewController" bundle:Nil];
    //[self.navigationController  presentViewController:addAlarmViewController animated:YES completion:Nil];
    [self.navigationController pushViewController:addAlarmViewController animated:YES];
    [addAlarmViewController release];
}

- (IBAction)testBtn:(id)sender {
            NSString* dateStr = @"2013-2-8 00:00:00";
            NSDateFormatter* formater = [[NSDateFormatter alloc] init];
            [formater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate* date = [formater dateFromString:dateStr];

    NSDictionary *setting = [[NSDictionary alloc]initWithObjectsAndKeys:date,DB_RECORD_SETTING_DATE,Nil];
    [db addAlarmClock:setting];
    [alarmRecords release];
    alarmRecords = [db allAlarmRecords];
    [_alarmListView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSLog(@"Test%d",[alarmRecords retainCount]);
    
    static NSString *CellIdentifier = @"CellTableIdentifier";
    
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"AlarmListCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    
    AlarmRecord *record = (AlarmRecord *)[alarmRecords objectAtIndex:indexPath.row];
    AlarmListCell *cell = (AlarmListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell initWithAlarmRecord:record];
    
    //[cell.countdown setText:@"15小时15分后响铃"];
    
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"将要显示%d条记录",[alarmRecords count]);
    return [alarmRecords count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)dealloc {
    [_alarmListItemView release];
    [_alarmListView release];
    [alarmRecords release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAlarmListItemView:Nil];
    [self setAlarmListView:Nil];
    alarmRecords = Nil;
    [super viewDidUnload];
}
@end
