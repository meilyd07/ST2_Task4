//
//  MainViewModel.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/7/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "MainViewModel.h"
#import "CalendarModel.h"
#import "DateUtil.h"
#import <EventKit/EventKit.h>

@interface MainViewModel()
@property (strong, nonatomic) NSMutableArray *weekData;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) CalendarModel *model;
@property (copy, nonatomic) NSArray *allEvents;
@end

@implementation MainViewModel
- (id) init
{
    self = [super init];
    if (!self) return nil;
    self.model = [CalendarModel new];
    self.selectedDate = [NSDate date];
    return self;
}

- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

-(void)loadEventsForWeek {
    NSDate *startDate = (NSDate *)self.weekData.firstObject;
    NSDate *stopDate = (NSDate *)self.weekData.lastObject;
    [self loadEventsForPeriod:startDate stopDate:stopDate];
}

-(void)loadEventsForPeriod:(NSDate *)startDate stopDate:(NSDate *)stopDate {
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:stopDate calendars:_eventCalendars];
    self.allEvents = [NSArray new];
    self.allEvents = [self.eventStore eventsMatchingPredicate:predicate];
}

-(void)loadCalendars {
    _eventCalendars = [[NSMutableArray alloc] init];
    NSArray *phoneCalendarArray = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    
    for (EKCalendar *systemCalendar in phoneCalendarArray)
    {
        NSLog(@"%@", systemCalendar.title);
        [_eventCalendars addObject:systemCalendar];
    }
}

-(void)loadWeek {
    self.weekData = [self.model arrayOfDates: self.selectedDate];
}

-(void)loadWeekByCount:(int)days {
    self.weekData = [self.model changeWeek:self.selectedDate byCount:days];
    self.selectedDate = [self.model changeDate:self.selectedDate byCount:days];
}

-(NSString *)getSelectedDateFormatted {
    return [DateUtil.sharedInstance getDateLocaleFormatted:self.selectedDate];
}

-(NSString *)getWeekDateStringBy:(NSInteger)index {
    NSDate *date = self.weekData[index];
    return [DateUtil.sharedInstance getDateNumber:date];
}

-(void)selectDateBy:(NSInteger)index {
    self.selectedDate = self.weekData[index];
}

-(BOOL)isSelected:(NSInteger)index {
    NSDate *date = self.weekData[index];
    return [[NSCalendar currentCalendar] isDate:self.selectedDate inSameDayAsDate:date];
}
@end
