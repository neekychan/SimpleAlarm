//
//  SimpleMenuView.m
//  SimpleAlarm
//
//  Created by Chan on 5/8/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import "SimpleMenuView.h"

@implementation SimpleMenuView
@synthesize tableView;
@synthesize titleArray;

static NSString *CellIdentifier = @"simpleMenuCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tableView.delegate = self;
        tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"SimpleMenuCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    }
    return self;
}


- (id)initWithMenuTitle:(NSArray *)titles {
    
    self = [super initWithFrame:CGRectMake(0, 0, 215, 200)];
    
    self.titleArray = titles;

    
    if (self) {
        if ([titles count] < 5) {
            [self setFrame:CGRectMake(5, (APPLICATION_VIEW_HEIGHT - [titles count] * 40) , 305, [titles count] * 42 )];
        } else {
            [self setFrame:CGRectMake(5, (APPLICATION_VIEW_HEIGHT -  5 * 42) , 305, 5 * 42 )];
        }
        
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titles {
    
    if(titleArray != titles) {
        titleArray = [titles retain];
    }
    
    tableView.delegate = self;
    tableView.dataSource = self;

    
    UINib *nib = [UINib nibWithNibName:@"SimpleMenuCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    if ([titles count] < 5) {
        [self setFrame:CGRectMake(5, (APPLICATION_VIEW_HEIGHT + [titles count] * 40) , 310, [titles count] * 42 )];
    } else {
        [self setFrame:CGRectMake(5, (APPLICATION_VIEW_HEIGHT +  5 * 42) , 310, 5 * 42 )];
    }
    
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate) {
        [self.delegate simpleMenuView:self itemSelected:indexPath.row];
        [self performSelector:@selector(unSelectRow:) withObject:indexPath afterDelay:.3];
    }
}

- (void)unSelectRow:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SimpleMenuCell *cell = (SimpleMenuCell *) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == Nil) {
        cell = [[[SimpleMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"simplemenu_item_bg"]] autorelease];
    cell.menuTitle.textColor = [UIColor darkGrayColor];
    
    
    if(titleArray != Nil)
        cell.menuTitle.text = [titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArray count];
}


- (void)dealloc {
    [tableView release];
    [titleArray release];
    [super dealloc];
}
@end
