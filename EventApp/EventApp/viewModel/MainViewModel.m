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

@interface MainViewModel()
@property (strong, nonatomic) NSMutableArray *weekData;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) CalendarModel *model;
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
