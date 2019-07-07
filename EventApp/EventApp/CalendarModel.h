//
//  CalendarModel.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/3/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject
-(NSMutableArray *)arrayOfDates:(NSDate *)startDate;
-(NSMutableArray *)changeWeek:(NSDate *)selectedDate byCount:(int)days;
@end
