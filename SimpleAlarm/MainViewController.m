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
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SimpleMenuView" owner:self options:nil];
    testMenu = [array objectAtIndex:0];
    [testMenu setTitleArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"3",@"3",@"3",Nil]];
    //实现圆角和阴影效果
    testMenu.layer.cornerRadius = 3 ;
    testMenu.layer.shadowOffset= CGSizeMake( 0, -2);
    testMenu.layer.shadowOpacity= .3;
    testMenu.layer.shadowRadius= 1.5;
    
    testMenu.delegate = self;
    
    [self.navigationBar setTitle:@"简单闹钟"];
    [self.navigationBar addForwardButton:@"添加" action:@selector(addAlarmAction)];
    
    
    //[self.view insertSubview:detailView aboveSubview:_alarmListItemView];
    NSArray *ar = [[NSBundle mainBundle]loadNibNamed:@"AlarmDetailView" owner:self options:nil];
    detailView = [ar objectAtIndex:0];
    [detailView setFrame:CGRectMake(0,-194, 320, 194)];

   
    alarmDetailViewbackground = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    alarmDetailViewbackground.backgroundColor = [UIColor blackColor];
    [alarmDetailViewbackground setAlpha:0];
    [alarmDetailViewbackground addTarget:self action:@selector(hideAlarmDetailView) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:alarmDetailViewbackground];
    [self.view addSubview:detailView];
    
    db = [[SimpleAlarmDataBase shareDataBase] retain];
    [_alarmListView setDelegate:self];
    [_alarmListView setDataSource:self];
    [_alarmListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//隐藏分割线
    [_alarmListView setShowsVerticalScrollIndicator:NO];
    self.alarmRecords = [db allAlarmRecords];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(recordUpdateNotify:) name:@"recordUpdate" object:Nil];
    
    [self.view addSubview:testMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (void)addAlarmAction {
    
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
    
//    AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithAlarmRecord:record];
    AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithNibName:@"AddAlarmViewController" bundle:Nil];
    [self.navigationController pushViewController:addAlarmViewController animated:YES];
    [addAlarmViewController release];
    [dic release];
    [cycle release];
    [record release];
}

- (IBAction)testBtn:(id)sender {
    
    //NSDate *date = [DateHelper dateWithYear:2013 month:4 day:23 hour:23 minute:11 second:0];
    NSDate *date = [NSDate date];
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

#pragma mark -notification delegate
- (void)recordUpdateNotify:(NSNotification *)notification {
    self.alarmRecords = [db allAlarmRecords];
    [self.alarmListView reloadData];
}


#pragma mark -tableview delegate
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
    
    return cell;
}


//可编辑与删除实现
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        AlarmRecord *record = [self.alarmRecords objectAtIndex:indexPath.row];        
        [[SimpleAlarmDataBase shareDataBase] deleteAlarmClock:record.ID];
        
        [self.alarmRecords removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"将要显示%d条记录",[self.alarmRecords count]);
    return [self.alarmRecords count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddAlarmViewController *addAlarmViewController = [[AddAlarmViewController alloc] initWithAlarmRecord:[self.alarmRecords objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:addAlarmViewController animated:YES];
    [addAlarmViewController release];
    
//    [detailView setAlarmRecord:[self.alarmRecords objectAtIndex:indexPath.row]];
//    [alarmDetailViewbackground setEnabled:YES];
//    [UIView beginAnimations:@"showAlarmDetailView" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelegate:self];
//    [detailView setFrame:CGRectMake(0, 0, 320, 194)];
//    [alarmDetailViewbackground setAlpha:0.5];
//    [UIView commitAnimations];
    
}


- (void)hideAlarmDetailView {
    [UIView beginAnimations:@"hideAlarmDetailView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [detailView setFrame:CGRectMake(0, -194, 320, 194)];
    [alarmDetailViewbackground setAlpha:0];
    [alarmDetailViewbackground setEnabled:NO];
    [UIView commitAnimations];

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
