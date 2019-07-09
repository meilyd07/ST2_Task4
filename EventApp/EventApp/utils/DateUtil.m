//
//  DateUtil.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/2/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "DateUtil.h"

@interface DateUtil ()
@property(strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation DateUtil

static DateUtil *shared = nil;

+ (DateUtil *) sharedInstance
{
    if (shared == nil)
    {
        shared = [[DateUtil alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        shared.dateFormatter = [[NSDateFormatter alloc] init];
        shared.dateFormatter.locale = locale;
        //shared.dateFormatter.dateFormat = @"d MMM yyyy";
    }
    return shared;
}

- (NSString *)getDateLocaleFormatted:(NSDate *)date {
    shared.dateFormatter.dateFormat = @"d MMMM yyyy";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *) getDateNumber:(NSDate *)date {
    shared.dateFormatter.dateFormat = @"d";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)timeFormatted:(int)totalMinutes
{
    int minutes = totalMinutes % 60;
    int hours = totalMinutes / 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

@end
