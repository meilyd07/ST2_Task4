//
//  DateUtil.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/2/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (DateUtil *) sharedInstance;
- (NSString *) getCurrentDate;
@end
