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
    NSDate *startOfTheWeek;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 2;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear
           startDate:&startOfTheWeek
            interval:&interval
             forDate:startDate];
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    [dates addObject:startOfTheWeek];
    
    for(int i= 1; i<numberOfDays; i++) {
        [offset setDay:i];
        NSDate *nextDate = [calendar dateByAddingComponents:offset toDate:startOfTheWeek options:NSCalendarMatchFirst];
        [dates addObject:nextDate];
    }
    
    return dates;
}

-(NSMutableArray *)changeWeek:(NSDate *)selectedDate byCount:(int)days {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    [offset setDay:days];
    NSDate *nextDate = [calendar dateByAddingComponents:offset toDate:selectedDate options:NSCalendarMatchFirst];
    return [self arrayOfDates:nextDate];
}
@end
