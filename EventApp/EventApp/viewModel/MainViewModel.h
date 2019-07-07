//
//  MainViewModel.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/7/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject
-(void)loadWeek;
-(void)loadWeekByCount:(int)days;
-(NSString *)getSelectedDateFormatted;
-(NSString *)getWeekDateStringBy:(NSInteger)index;
-(void)selectDateBy:(NSInteger)index;
-(BOOL)isSelected:(NSInteger)index;
@end
