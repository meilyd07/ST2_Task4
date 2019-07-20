//
//  MainCollectionViewLayoutDelegate.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/20/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainCollectionViewLayout.h"

@protocol MainCollectionViewLayoutDelegate <NSObject>
- (NSRange)mainCollectionViewLayout:(MainCollectionViewLayout *)layout timespanForCellAtIndexPath:(NSIndexPath *)indexPath;

@end
