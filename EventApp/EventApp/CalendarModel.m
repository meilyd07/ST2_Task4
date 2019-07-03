//
//  CalendarModel.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/3/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "CalendarModel.h"

@implementation CalendarModel

-(NSMutableArray *)arrayOfDates:(NSDate *)startDate {
    
    int numberOfDays = 7;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offset = [[NSDateComponents alloc] init];
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
