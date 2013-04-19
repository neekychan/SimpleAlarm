//
//  DefaultDelegate.h
//  SimpleAlarm
//
//  Created by chan on 3/10/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DefaultDelegate <NSObject>

@required
- (void)actionPerform:(id)actionSource;

@end
