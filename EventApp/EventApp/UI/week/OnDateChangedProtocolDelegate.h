//
//  OnDateChangedProtocolDelegate.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OnDateChangedProtocolDelegate <NSObject>
@required
- (void)onDateChanged;
@end
