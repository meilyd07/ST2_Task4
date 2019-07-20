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
- (NSString *) getDateNumber:(NSDate *)date;
- (NSString *)getDateLocaleFormatted:(NSDate *)date;
- (NSString *)timeFormatted:(int)totalMinutes;
- (NSDate *)dateWithOutTime:(NSDate *)datDate;
- (NSDate *)nextDay:(NSDate *)datDate;
@end
