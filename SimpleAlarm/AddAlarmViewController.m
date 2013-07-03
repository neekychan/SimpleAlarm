//
//  AddAlarmViewController.m
//  SimpleAlarm
//
//  Created by chan on 2/8/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "MainViewController.h"
#import "SettingViewCell.h"
#import "CycleSettingViewController.h"


#define kSETTING_SECTION_NUMBER 3
#define kSETTING_SECTION_TIMER 0
#define kSETTING_SECTION_CUSTOM 1
#define kSETTING_SECTION_MESSAGE 2

#define kSETTING_SECTION_TIMER_TIME 0
#define kSETTING_SECTION_TIMER_CYCLE 1
#define kSETTING_SECTION_TIMER_REST_TIME 2
#define kSETTING_SECTION_TIMER_TYPE 3

#define kSETTING_SECTION_CUSTOM_RINGTYPE 0
#define kSETTING_SECTION_CUSTOM_IMAGE 1

#define kSETTING_TIMEPICKER_DEFAULT_SELECT_HOUR 7
#define kSETTING_TIMEPICKER_DEFAULT_SELECT_MINUS 30
#define kSETTING_TIMEPICKER_COLUMN_COUNT 2
#define kSETTING_TIMEPICKER_COLUMN_HOUR 0
#define kSETTING_TIMEPICKER_COLUMN_MINUS 1
#define kSETTING_TIMEPICKER_COLUMN_HOUR_COUNT 24
#define kSETTING_TIMEPICKER_COLUMN_MINUS_COUNT 60

#define kVALUEPICKER_ID_REST_TIME 1
#define kVALUEPICKER_ID_ALARM_TYPE 2

@interface AddAlarmViewController ()

@end

@implementation AddAlarmViewController

@synthesize setting;


static NSString *CellIdentifier = @"settingCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithAlarmRecord:(AlarmRecord *)record {
    
    self = [super initWithNibName:@"AddAlarmViewController" bundle:Nil];
    if(self) {
        [self setSetting:record];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isMessageTextViewEmpty = YES;
    
    settingTiles = [[NSArray alloc] initWithObjects:@"时间",@"周期",@"小睡",@"类型",nil];
    settingIcons = [[NSArray alloc] initWithObjects:@"icon_clock",@"icon_cycle",@"icon_rest_time",@"icon_alarm_type", nil];
    settingCustomTitle = [[NSArray alloc] initWithObjects:@"铃声",@"照片",nil];
    settingCustomIcons = [[NSArray alloc] initWithObjects:@"icon_picture",@"icon_picture", nil];
    settingTypeTitle = [[NSArray alloc] initWithObjects:@"单次闹钟",@"起床闹钟", nil];
    settingCustomRingTitle = [[NSArray alloc] initWithObjects:@"默认",@"小鸟叫声", nil];
    
    [_timePicker setDataSource:self];
    [_timePicker setDelegate:self];
    [_timePicker setFrame:CGRectMake(0, APPLICATION_VIEW_HEIGHT, 320, 216)];
    
    [self initUIValuePicker];
    

    
    if(setting) {
        
        [self.navigationBar setTitle:@"编辑闹钟"];
        [self.navigationBar addForwardButton:@"保存" action:@selector(saveBtnAction)];
        [self.navigationBar addBackButton:@"返回" action:@selector(returnBtnAction)];
        isMessageTextViewEmpty = NO;
        
    } else {
        //当前为创建模式的情况下，新建一个默认的setting参数
        AlarmRecord *defaultSetting = [[AlarmRecord alloc] init];
        NSDate *defaultTime = [NSDate date];
        NSDateComponents *com = [DateHelper componentsWithDate:defaultTime];
        [com setHour:7];
        [com setMinute:0];
        defaultTime = [DateHelper dateWithComponenets:com];
        defaultSetting.ID = -1;//-1为新建一条新纪录
        defaultSetting.time = defaultTime;
        defaultSetting.cycle = @"1,2,3,4,5";
        defaultSetting.restTime = 10;
        defaultSetting.type = kAlarmRecordTypeWakeup;
        defaultSetting.ringType = kAlarmRecordRingTypeDefault;
        defaultSetting.status = YES;
        [self setSetting:defaultSetting];
        [defaultSetting release];
        
        [self.navigationBar setTitle:@"添加闹钟"];
        [self.navigationBar addForwardButton:@"保存" action:@selector(saveBtnAction)];
        [self.navigationBar addBackButton:@"返回" action:@selector(returnBtnAction)];
    }
    
    
    
    NSDateComponents *components = [DateHelper componentsWithDate:[setting time]];
    NSInteger mins = [components minute];
    NSInteger hour = [components hour];
    //将时间选择器的刻度与当前时间保持一致
    [_timePicker selectRow:hour inComponent:kSETTING_TIMEPICKER_COLUMN_HOUR animated:NO];
    [_timePicker selectRow:mins inComponent:kSETTING_TIMEPICKER_COLUMN_MINUS animated:NO];
    
    [_settingTableView setDataSource:self];
    [_settingTableView setDelegate:self];
    
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    [_settingTableView setBackgroundView:backGroundImageView];
    [backGroundImageView release];

    
    UINib *nib = [UINib nibWithNibName:@"SettingViewCell" bundle:nil];
    [_settingTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(cycleSelectedNotify:) name:@"cycleSelected" object:Nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigation delegate

- (void)returnBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnAction {
    
    if(setting) {
        [[SimpleAlarmDataBase shareDataBase] updateAlarmClock:setting];
    }
    
    if(setting && setting.ID == -1) {
        [[SimpleAlarmDataBase shareDataBase] addAlarmClock:setting];
    }
     
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recordUpdate" object:Nil];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - textview delegate

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    
    
    if (isMessageTextViewEmpty) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isMessageTextViewEmpty = NO;
    }
    
    
    [_settingTableView setContentSize:CGSizeMake(320, 960)];
    CGRect zoomRect = CGRectMake(0,270 + (iPhone5?88:0),320,360);
    [_settingTableView scrollRectToVisible:zoomRect animated:YES];
    [self.settingTableView setScrollEnabled:NO];
    
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"如:起床以后要做些什么?";
        isMessageTextViewEmpty = YES;
    }
    
    setting.message = textView.text;
    
    [self.settingTableView setScrollEnabled:YES];
    CGRect zoomRect = CGRectMake(0,0,320,460 + (iPhone5?88:0));
    [_settingTableView scrollRectToVisible:zoomRect animated:YES];
    [self performSelector:@selector(restoreView) withObject:Nil afterDelay:.5];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.length != 1 && [text isEqualToString:@"\n"]){
        [self hideKeyBoard:textView];
        return NO;
    }
    
    return YES;
}

#pragma mark - simplemenuview delegate


- (void)initUIValuePicker{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SimpleMenuView" owner:self options:nil];
    valuePicker = [array objectAtIndex:0];
    
    [valuePicker setDelegate:self];
    [valuePicker setFrame:CGRectMake(10, APPLICATION_VIEW_HEIGHT, 10 , 10)];
    [self.view addSubview:valuePicker];
    
    //实现圆角和阴影效果
    valuePicker.layer.cornerRadius = 3 ;
    valuePicker.layer.shadowOffset= CGSizeMake(0,0);
    valuePicker.layer.shadowOpacity= .5;
    valuePicker.layer.shadowRadius= 1.5;
}

- (void)simpleMenuView:(SimpleMenuView *)view itemSelected:(NSInteger)itemId {
    switch (view.targetId) {
        case kSETTING_SECTION_TIMER_REST_TIME:
            switch (itemId) {
                case 0:
                    setting.restTime = 0;
                    break;
                case 1:
                    setting.restTime = 5;
                    break;
                case 2:
                    setting.restTime = 10;
                    break;
                case 3:
                    setting.restTime = 15;
                    break;
                case 4:
                    setting.restTime = 20;
                    break;
                    
                default:
                    break;
            }
            break;
        case kSETTING_SECTION_TIMER_TYPE:
            switch (itemId) {
                case 0:
                    setting.type = kAlarmRecordTypeWakeup;
                    break;
                case 1:
                    setting.type = kAlarmRecordTypeAlarm;
                    
                default:
                    break;
            }
            
        default:
            break;
    }
    
    [self.settingTableView reloadData];
    [self hideValuePicker];
}

- (void)showValuePicker{
    
    [UIView beginAnimations:@"ShowValuePicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    CGRect rect = valuePicker.frame;
    rect.origin.y = APPLICATION_VIEW_HEIGHT - rect.size.height - 5;
    [valuePicker setFrame:rect];
    [UIView commitAnimations];
}

- (void)hideValuePicker{
    
    
    [valuePicker setTargetId:-1];
    
    [UIView beginAnimations:@"HideValuePicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationDelegate:self];
    CGRect rect = valuePicker.frame;
    rect.origin.y = APPLICATION_VIEW_HEIGHT;
    [valuePicker setFrame:rect];
    [UIView commitAnimations];
}

- (BOOL)isValuePickerHide{
    if(valuePicker.frame.origin.y >= APPLICATION_VIEW_HEIGHT)
        return YES;
    return NO;
}

- (void)setValuePickerWithTitles:(NSArray *)titles targetId:(NSInteger)targetId {
    if([valuePicker targetId] == targetId){
        [self hideValuePicker];
        [valuePicker setTargetId:-1];
        return;
    } else {
        if([self isValuePickerHide] == NO){
            [self hideValuePicker];
        }
    }
    
    if([self isValuePickerHide] == YES ) {
        
        [valuePicker setTitleArray:titles];
        [valuePicker setTargetId:targetId];
        [self showValuePicker];
        
        
    }
}



#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case kSETTING_SECTION_TIMER:
            return [settingTiles count];
        case kSETTING_SECTION_CUSTOM:
            return 2;
        case kSETTING_SECTION_MESSAGE:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  kSETTING_SECTION_NUMBER;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == kSETTING_SECTION_MESSAGE){
        return iPhone5 ? 90 + 88 : 90;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SettingViewCell *cell = (SettingViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == Nil) {
        cell = [[[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell setBackgroundColor:UIColor.whiteColor];
	
    switch (indexPath.section) {
        case kSETTING_SECTION_TIMER:
            
            cell.titleLabel.text = [settingTiles objectAtIndex:indexPath.row];
            UIImage *iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[settingIcons objectAtIndex:indexPath.row]]];
            cell.iConImageView.image = iconImage;
            
            switch (indexPath.row) {
                case kSETTING_SECTION_TIMER_TIME:{
                    
                    NSDateComponents *component = [DateHelper componentsWithDate:[setting time]];
                    NSString *text = [NSString stringWithFormat:@"%@:%@",[DateHelper decadeNumberFormat:component.hour],[DateHelper decadeNumberFormat:component.minute]];
                    cell.contentLabel.text = text;
                    [cell.extendIconImageView setHidden:YES];
                    
                }
                    break;
                case kSETTING_SECTION_TIMER_CYCLE:{
                    cell.contentLabel.text = [self cycleTitle:setting.cycle];
                    break;
                }
                case kSETTING_SECTION_TIMER_REST_TIME:{
                    
                    NSString *restTime = [NSString stringWithFormat:@"%d分钟",setting.restTime];
                    cell.contentLabel.text = restTime;
                    [cell.extendIconImageView setHidden:YES];
                }
                    break;
                case kSETTING_SECTION_TIMER_TYPE:{
                    
                    cell.contentLabel.text = [settingTypeTitle objectAtIndex:setting.type];
                    [cell.extendIconImageView setHidden:YES];
                    
                }
                default:
                    break;
            }
            
            break;
        case kSETTING_SECTION_CUSTOM: {
            
            cell.titleLabel.text = [settingCustomTitle objectAtIndex:indexPath.row];
            
            UIImage *iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[settingCustomIcons objectAtIndex:indexPath.row]]];
            cell.iConImageView.image = iconImage;
            
            switch (indexPath.row) {
                case kSETTING_SECTION_CUSTOM_RINGTYPE:
                    cell.contentLabel.text = [settingCustomRingTitle objectAtIndex:setting.ringType];
                    [cell.extendIconImageView setHidden:YES];
                    break;
                case kSETTING_SECTION_CUSTOM_IMAGE:
                    if (setting.image == Nil)
                        cell.contentLabel.text = @"未设置";
                default:
                    break;
            }
            
        }
            break;
        case kSETTING_SECTION_MESSAGE:{
            [cell setTextViewMode:YES];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
            if (setting.message && !isMessageTextViewEmpty) {
                cell.messageTextView.text = setting.message;
                cell.messageTextView.textColor = [UIColor blackColor];
                isMessageTextViewEmpty = NO;
            }
        }
            break;
        default:
            break;
    }
    
	
	return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if([self isValuePickerHide] == NO){
//        [self hideValuePicker];
//    }
    
    currentCell = (SettingViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case kSETTING_SECTION_TIMER:
            
            switch (indexPath.row) {
                    
                case kSETTING_SECTION_TIMER_TIME:
                    
                    
                    if(self.timePicker.frame.origin.y == APPLICATION_VIEW_HEIGHT){
                        
                        [self restoreView];
                        
                        [self.timePicker setHidden:NO];
                        [UIView beginAnimations:@"ShowHideTimePicker" context:nil];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                        [UIView setAnimationDuration:.3];
                        [UIView setAnimationDelegate:self];
                        [self.timePicker setFrame:CGRectMake(0, APPLICATION_VIEW_HEIGHT - 216, 320, 216)];
                        [UIView commitAnimations];
                        
                    } else {
                        
                        [UIView beginAnimations:@"HideTimePicker" context:nil];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                        [UIView setAnimationDuration:.3];
                        [UIView setAnimationDelegate:self];
                        [self.timePicker setFrame:CGRectMake(0,APPLICATION_VIEW_HEIGHT, 320, 216)];
                        [UIView commitAnimations];
                        [self.settingTableView deselectRowAtIndexPath:indexPath animated:YES];
                        
                    }
                    break;
                    
                    
                case kSETTING_SECTION_TIMER_CYCLE:{
                    
                    CycleSettingViewController *cycleSettingView = [[CycleSettingViewController alloc] initWithNibName:@"CycleSettingViewController" bundle:Nil];
                    [cycleSettingView setDefaultSetting:setting.cycle];
                    [self.navigationController pushViewController:cycleSettingView animated:YES];
                    [self.settingTableView deselectRowAtIndexPath:indexPath animated:YES];
                    [cycleSettingView release];
                }
                    break;
                    
                    
                case kSETTING_SECTION_TIMER_REST_TIME:
                    
                    [self setValuePickerWithTitles:[NSArray arrayWithObjects:@"无",@"5分钟",@"10分钟",@"15分钟",@"20分钟", nil] targetId:kSETTING_SECTION_TIMER_REST_TIME];
                    break;
                
                case kSETTING_SECTION_TIMER_TYPE:

                    [self setValuePickerWithTitles:settingTypeTitle targetId:kSETTING_SECTION_TIMER_TYPE];
                    break;
                default:
                    break;
            }
            
            break;
            
        case kSETTING_SECTION_CUSTOM: {
            
            switch (indexPath.row) {
                case kSETTING_SECTION_CUSTOM_RINGTYPE:
                    
                    [self setValuePickerWithTitles:settingCustomRingTitle targetId:kVALUEPICKER_ID_ALARM_TYPE];
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case kSETTING_SECTION_MESSAGE:
            break;
        default:
            break;
    }
}

#pragma mark - timepicker datasource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 200;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return kSETTING_TIMEPICKER_COLUMN_COUNT;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case kSETTING_TIMEPICKER_COLUMN_HOUR:
            return 70;
            break;
        case kSETTING_TIMEPICKER_COLUMN_MINUS:
            return 70;
        default:
            break;
    }
    return 45;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case kSETTING_TIMEPICKER_COLUMN_HOUR:
            row = row % kSETTING_TIMEPICKER_COLUMN_HOUR_COUNT;
            break;
        case kSETTING_TIMEPICKER_COLUMN_MINUS:
            row = row % kSETTING_TIMEPICKER_COLUMN_MINUS_COUNT;
            break;
        default:
            break;
    }
    
    if (row < 10) {
        return [NSString stringWithFormat:@"  %d%@",row,component == kSETTING_TIMEPICKER_COLUMN_HOUR ? @"时":@"分"];
    }
    
    return [NSString stringWithFormat:@" %d%@",row,component == kSETTING_TIMEPICKER_COLUMN_HOUR ? @"时":@"分"];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger hour = [_timePicker selectedRowInComponent:kSETTING_TIMEPICKER_COLUMN_HOUR] % kSETTING_TIMEPICKER_COLUMN_HOUR_COUNT;
    NSInteger minus = [_timePicker selectedRowInComponent:kSETTING_TIMEPICKER_COLUMN_MINUS] % kSETTING_TIMEPICKER_COLUMN_MINUS_COUNT;

    NSDateComponents *comp = [DateHelper componentsWithDate:setting.time];
    [comp setHour:hour];
    [comp setMinute:minus];
    setting.time = [DateHelper dateWithComponenets:comp];
    [_settingTableView reloadData];
    
}

- (void)hideTimePicker{
    [UIView beginAnimations:@"HideTimePicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    [self.timePicker setFrame:CGRectMake(0,APPLICATION_VIEW_HEIGHT, 320, 216)];
    [UIView commitAnimations];
    [self.timePicker setHidden:YES];
}

#pragma mark- other

-(void) cycleSelectedNotify:(NSNotification *)notification{
    
    NSMutableString *cycle = [[NSMutableString alloc] init];
    NSDictionary *tmpDics = notification.object;
    for(id key in tmpDics.allKeys) {
        NSString *value = [tmpDics objectForKey:key];
        [cycle appendFormat:@"%@,",value];
    }
    //删除结尾的逗号
    [cycle deleteCharactersInRange:NSMakeRange(cycle.length - 1,1)];
    
    setting.cycle = cycle;
    [cycle release];
    
    [_settingTableView reloadData];
}

-(NSString *) cycleTitle:(NSString *)str {
    NSString *title = @"工作日";
    NSArray *cycles = [str componentsSeparatedByString:@","];
    if ([cycles containsObject:@"6"] && [cycles containsObject:@"7"] && cycles.count == 2) {
        title = @"周末";
    } else if(cycles.count == 5 && !([cycles containsObject:@"6"] && [cycles containsObject:@"7"])){
        title = @"工作日";
    }
    return title;
}



//隐藏键盘
- (void)hideKeyBoard:(id)sender{
    
    UITextView *textView = (UITextView *)sender;
    if(textView != Nil){
        [textView resignFirstResponder];
    }
    
}


/*重置窗口，取消已显示选项。*/
- (void)restoreView{
    [self.settingTableView reloadData];
    [self.settingTableView setContentSize:CGSizeMake(self.settingTableView.frame.size.width, self.settingTableView.frame.size.height)];
    [self hideTimePicker];
    [self hideValuePicker];
}




- (void)viewWillDisappear:(BOOL)animated{
    [self restoreView];
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [_saveButton release];
    [_settingTableView release];
    [settingTiles release];
    [settingIcons release];
    [settingCustomTitle release];
    [settingCustomIcons release];
    [settingTypeTitle release];
    [_messageTextView release];
    [_timePicker release];
    //[valuePicker release];自动释放的
    [super dealloc];
}
- (void)viewDidUnload {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:@"cycleSelected" object:Nil];
    [self setSaveButton:nil];
    [self setSettingTableView:nil];
    settingIcons = Nil;
    settingTiles = Nil;
    [self setMessageTextView:nil];
    [self setTimePicker:nil];
    [super viewDidUnload];
}
@end
