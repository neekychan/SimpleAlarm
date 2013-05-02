//
//  MainViewController.m
//  SimpleAlarm
//
//  Created by chan on 1/30/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (retain, nonatomic) NSMutableArray *alarmRecords;
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
    
    [self.navigationBar setTitle:@"简单闹钟"];
    [self.navigationBar addForwardButton:@"添加" action:@selector(addAlarmAction)];
    
    db = [[SimpleAlarmDataBase shareSimpleAlarmDataBase] retain];
    [_alarmListView setDelegate:self];
    [_alarmListView setDataSource:self];
    [_alarmListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//隐藏分割线
    [_alarmListView setShowsVerticalScrollIndicator:NO];
    self.alarmRecords = [db allAlarmRecords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void)addAlarmAction {
    //[db addAlarmClock:Nil];
    //AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithNibName:@"AddAlarmViewController" bundle:Nil];
    
    NSDate *date = [DateHelper dateWithYear:2013 month:4 day:23 hour:23 minute:11 second:0];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"6",@"6",@"7",@"7", nil];
    
    NSMutableString *cycle = [[NSMutableString alloc] init];
    
    for(id key in dic.allKeys) {
        NSString *value = [dic objectForKey:key];
        [cycle appendFormat:@"%@,",value];
    }
    //删除结尾的逗号
    [cycle deleteCharactersInRange:NSMakeRange(cycle.length - 1,1)];
    
    AlarmRecord *record = [[AlarmRecord alloc] init];
    record.time = date;
    record.type = 1;
    record.cycle = cycle;
    record.message = @"No Message";
    record.restTime = 10;
    
    AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithAlarmRecord:record];
    [self.navigationController pushViewController:addAlarmViewController animated:YES];
    [addAlarmViewController release];
    [dic release];
    [cycle release];
    [record release];
}

- (IBAction)testBtn:(id)sender {
    
    NSDate *date = [DateHelper dateWithYear:2013 month:4 day:23 hour:23 minute:11 second:0];

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"1",@"3",@"5",@"5",@"5", nil];
    
    NSMutableString *cycle = [[NSMutableString alloc] init];
    
    for(id key in dic.allKeys) {
        NSString *value = [dic objectForKey:key];
        [cycle appendFormat:@"%@,",value];
    }
    //删除结尾的逗号
    [cycle deleteCharactersInRange:NSMakeRange(cycle.length - 1,1)];
    
    AlarmRecord *record = [[AlarmRecord alloc] init];
    record.time = date;
    record.type = 1;
    record.cycle = cycle;
    record.message = @"No Message";
    record.restTime = 10;
    
    [db addAlarmClock:record];
    
    [record release];
    [dic release];
    [cycle release];
    
    self.alarmRecords = [db allAlarmRecords];
    [self.alarmListView reloadData];
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
    
    AlarmRecord *record = (AlarmRecord *)[self.alarmRecords objectAtIndex:indexPath.row];
    AlarmListCell *cell = (AlarmListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == Nil) {
        cell = [[[AlarmListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell initWithAlarmRecord:record];
    
    //[cell.countdown setText:@"15小时15分后响铃"];
    
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"将要显示%d条记录",[self.alarmRecords count]);
    return [self.alarmRecords count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)dealloc {
    [_alarmListItemView release];
    [_alarmListView release];
    [_alarmRecords release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAlarmListItemView:Nil];
    [self setAlarmListView:Nil];
    self.alarmRecords = Nil;
    [super viewDidUnload];
}
@end
