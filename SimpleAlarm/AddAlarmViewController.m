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


#define kSETTING_SECTION_NUMBER 2
#define kSETTING_SECTION_TIMER 0
#define kSETTING_SECTION_MESSAGE 1
#define kSETTING_SECTION_TIMER_TIME 0
#define kSETTING_SECTION_TIMER_CYCLE 1
#define kSETTING_SECTION_TIMER_REST_TIME 2

#define kSETTING_TIMEPICKER_DEFAULT_SELECT_HOUR 7
#define kSETTING_TIMEPICKER_DEFAULT_SELECT_MINUS 30
#define kSETTING_TIMEPICKER_COLUMN_COUNT 2
#define kSETTING_TIMEPICKER_COLUMN_HOUR 0
#define kSETTING_TIMEPICKER_COLUMN_MINUS 1
#define kSETTING_TIMEPICKER_COLUMN_HOUR_COUNT 24
#define kSETTING_TIMEPICKER_COLUMN_MINUS_COUNT 60

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

- (id)initWithSetting:(NSDictionary *)settings {
    
    [self initWithNibName:@"AddAlarmViewController" bundle:Nil];
    [self setSetting:settings];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isMessageTextViewEmpty = YES;
    
    settingTiles = [[NSArray alloc] initWithObjects:@"时间",@"周期",@"小睡",nil];
    settingIcons = [[NSArray alloc] initWithObjects:@"icon_clock",@"icon_cycle",@"icon_rest_time", nil];
    
    [_timePicker setDataSource:self];
    [_timePicker setDelegate:self];
    [_timePicker setFrame:CGRectMake(0, 460 + (iPhone5?88:0), 320, 216)];
    
    if(setting) {
        [self.navigationBar setTitle:@"编辑闹钟"];
        [self.navigationBar addForwardButton:@"保存" action:@selector(saveBtnAction)];
        [self.navigationBar addBackButton:@"返回" action:@selector(returnBtnAction)];
        
        NSDateComponents *components = [DateHelper componentsWithDate:[NSDate date]];
        NSInteger mins = [components minute];
        NSInteger hour = [components hour];
        
        [_timePicker selectRow:hour inComponent:kSETTING_TIMEPICKER_COLUMN_HOUR animated:NO];
        [_timePicker selectRow:mins inComponent:kSETTING_TIMEPICKER_COLUMN_MINUS animated:NO];
        
    } else {
        [self.navigationBar setTitle:@"添加闹钟"];
        [self.navigationBar addForwardButton:@"保存" action:@selector(saveBtnAction)];
        [self.navigationBar addBackButton:@"返回" action:@selector(returnBtnAction)];
        [_timePicker selectRow:kSETTING_TIMEPICKER_DEFAULT_SELECT_HOUR inComponent:kSETTING_TIMEPICKER_COLUMN_HOUR animated:NO];
        [_timePicker selectRow:kSETTING_TIMEPICKER_DEFAULT_SELECT_MINUS inComponent:kSETTING_TIMEPICKER_COLUMN_MINUS animated:NO];
    }
    

    
    [_settingTableView setDataSource:self];
    [_settingTableView setDelegate:self];
    
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    [_settingTableView setBackgroundView:backGroundImageView];
    [backGroundImageView release];
    


    UINib *nib = [UINib nibWithNibName:@"SettingViewCell" bundle:nil];
    [_settingTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark navigation delegate

- (void)returnBtnAction {
    
    //[self dismissViewControllerAnimated:YES completion:Nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnAction {
}


#pragma mark -textview delegate

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    
    [textView becomeFirstResponder];
    
    if (isMessageTextViewEmpty) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isMessageTextViewEmpty = NO; 
    }
    
    
    [_settingTableView setContentSize:CGSizeMake(320, 960)];
    
    CGRect zoomRect = CGRectMake(0,270 + (iPhone5?88:0),320,300);
    [_settingTableView scrollRectToVisible:zoomRect animated:YES];
    [self.settingTableView setScrollEnabled:NO];
    //[_settingTableView scrollRectToVisible:CGRectMake(10, 300, 300, 200) animated:YES];
    //[hiddenKeyBoardView setHidden:NO];
    
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"如:起床以后要做些什么?";
        isMessageTextViewEmpty = YES;
    }
    [self.settingTableView setScrollEnabled:YES];
    CGRect zoomRect = CGRectMake(0,0,320,460 + (iPhone5?88:0));
    [_settingTableView scrollRectToVisible:zoomRect animated:YES];
    [self performSelector:@selector(restoreView) withObject:Nil afterDelay:.5];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.length != 1 && [text isEqualToString:@"\n"]){
        [self hideKeyBoard:textView];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark -tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case kSETTING_SECTION_TIMER:
            return [settingTiles count];
            break;
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
            return iPhone5 ? 220 + 88 : 220;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    SettingViewCell *cell = (SettingViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == Nil) {
        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setBackgroundColor:UIColor.whiteColor];
	
    switch (indexPath.section) {
        case kSETTING_SECTION_TIMER:
        
            cell.titleLabel.text = [settingTiles objectAtIndex:indexPath.row]; 
            UIImage *iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[settingIcons objectAtIndex:indexPath.row]]];
            cell.iConImageView.image = iconImage;
            
            switch (indexPath.row) {
                case kSETTING_SECTION_TIMER_TIME:{
                    
                    if (setting) {
                        NSDateComponents *component = [DateHelper componentsWithDate:[NSDate date]];
                        NSString *text = [NSString stringWithFormat:@"%@:%@",[DateHelper decadeNumberFormat:component.hour],[DateHelper decadeNumberFormat:component.minute]];
                        cell.contentLabel.text = text;
                    } else {
                        cell.contentLabel.text = @"07:30";
                    }

                }
                    break;
                case kSETTING_SECTION_TIMER_CYCLE:
                    cell.contentLabel.text = @"工作日";
                    break;
                case kSETTING_SECTION_TIMER_REST_TIME:
                    cell.contentLabel.text = @"5分钟";
                default:
                    break;
            }
            
            break;
        case kSETTING_SECTION_MESSAGE:{  
            [cell setTextViewMode:YES];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
            break;
        default:
            break;
    }

	
	return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentCell = (SettingViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case kSETTING_SECTION_TIMER:
            
            switch (indexPath.row) {
                    
                case kSETTING_SECTION_TIMER_TIME:

                    if(self.timePicker.frame.origin.y >= 460){
                        
                        [self.timePicker setHidden:NO];
                        [UIView beginAnimations:@"ShowHideTimePicker" context:nil];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                        [UIView setAnimationDuration:.3];
                        [UIView setAnimationDelegate:self];
                        [self.timePicker setFrame:CGRectMake(0, 244 + (iPhone5?88:0), 320, 216)];
                        [UIView commitAnimations];
                        
                    } else {
                        
                        [UIView beginAnimations:@"HideTimePicker" context:nil];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                        [UIView setAnimationDuration:.3];
                        [UIView setAnimationDelegate:self];
                        [self.timePicker setFrame:CGRectMake(0,460 + (iPhone5?88:0), 320, 216)];
                        [UIView commitAnimations];
                        [self.settingTableView deselectRowAtIndexPath:indexPath animated:YES];
                        
                    }
                    break;
                case kSETTING_SECTION_TIMER_CYCLE:{
                    
                    CycleSettingViewController *cycleSettingView = [[CycleSettingViewController alloc] initWithNibName:@"CycleSettingViewController" bundle:Nil];
                    [self.navigationController pushViewController:cycleSettingView animated:YES];
                    [self.settingTableView deselectRowAtIndexPath:indexPath animated:YES];
                    [cycleSettingView release];                    
                }
                    break;
                default:
                    break;
            }

            break;
         case kSETTING_SECTION_MESSAGE:
            break;
        default:
            break;
    }
    }

#pragma mark -timepicker datasource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 200;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return kSETTING_TIMEPICKER_COLUMN_COUNT;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case kSETTING_TIMEPICKER_COLUMN_HOUR:
            return 50;
            break;
        case kSETTING_TIMEPICKER_COLUMN_MINUS:
            return 45;
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
        return [NSString stringWithFormat:@"  %d",row];
    }
    
    return [NSString stringWithFormat:@" %d",row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    NSInteger hour = [_timePicker selectedRowInComponent:kSETTING_TIMEPICKER_COLUMN_HOUR] % kSETTING_TIMEPICKER_COLUMN_HOUR_COUNT;
    NSInteger minus = [_timePicker selectedRowInComponent:kSETTING_TIMEPICKER_COLUMN_MINUS] % kSETTING_TIMEPICKER_COLUMN_MINUS_COUNT;
    NSString *strHour = [NSString stringWithFormat:@"%d",hour];
    NSString *strMinus = [NSString stringWithFormat:@"%d",minus];

    if(currentCell != Nil){
        if(hour < 10){
            strHour = [NSString stringWithFormat:@"0%d",hour];
        }
        if(minus < 10){
            strMinus = [NSString stringWithFormat:@"0%d",minus];
        }
        [currentCell.contentLabel setText:[NSString stringWithFormat:@"%@:%@",strHour,strMinus]];
    }

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
    [UIView beginAnimations:@"HideTimePicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    [self.timePicker setFrame:CGRectMake(0,460 + (iPhone5?88:0), 320, 216)];
    [UIView commitAnimations];
    [self.settingTableView setContentSize:CGSizeMake(self.settingTableView.frame.size.width, self.settingTableView.frame.size.height)];
    [self.timePicker setHidden:YES];
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
    [_messageTextView release];
    [_timePicker release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSaveButton:nil];
    [self setSettingTableView:nil];
    settingIcons = Nil;
    settingTiles = Nil;
    [self setMessageTextView:nil];
    [self setTimePicker:nil];
    [super viewDidUnload];
}
@end
