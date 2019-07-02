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
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_BY"];
        shared.dateFormatter = [[NSDateFormatter alloc] init];
        shared.dateFormatter.locale = locale;
        shared.dateFormatter.dateFormat = @"d MMM yyyy";
    }
    return shared;
}

- (NSString *) getCurrentDate {
    
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

@end
