//
//  MainCollectionViewLayout.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewLayout : UICollectionViewLayout

@end

@protocol CalendarViewLayoutDelegate <NSObject>
- (NSRange)calendarViewLayout:(MainCollectionViewLayout *)layout timespanForCellAtIndexPath:(NSIndexPath *)indexPath;

@end
