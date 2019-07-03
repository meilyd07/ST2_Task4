//
//  CalendarModel.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/3/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "CalendarModel.h"

@implementation CalendarModel

-(NSArray *)arrayOfDates {
    
    int numberOfDays = 7;
    NSDate *startDate = [NSDate date];
    //formatter.dateFormat = "EEE d/M"
    //let calendar = Calendar.current
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //var offset = DateComponents()
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    //[dateComponent setYear:2020];
    //var dates: [Any] = [formatter.string(from: startDate)]
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    [dates addObject:startDate];
    
    for(int i= 1; i<numberOfDays; i++) {
        [offset setDay:i];
        NSDate *nextDate = [calendar dateByAddingComponents:offset toDate:startDate options:NSCalendarMatchFirst];
        [dates addObject:nextDate];
    }
    
    return dates;
}
@end
