//
//  MainViewModel.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/7/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface MainViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *eventCalendars;
@property (strong, nonatomic) EKEventStore *eventStore;

-(void)loadWeek;
-(void)loadWeekByCount:(int)days;
-(NSString *)getSelectedDateFormatted;
-(NSString *)getWeekDateStringBy:(NSInteger)index;
-(void)selectDateBy:(NSInteger)index;
-(BOOL)isSelected:(NSInteger)index;

-(NSString *)getEventTextForRow:(NSInteger)index;
-(NSDate *)getEventStartDateForRow:(NSInteger)index;
-(NSDate *)getEventStopDateForRow:(NSInteger)index;
-(NSInteger)getCountOfEvents;

-(void)loadCalendars;
-(void)loadEventsForWeek;
-(void)loadEventsForSelectedDay;
@end
