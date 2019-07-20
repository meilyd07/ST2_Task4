//
//  EventsCollectionView.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/20/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCollectionViewLayoutDelegate.h"

@interface EventsCollectionView : UICollectionView
@property(nonatomic, weak) id<MainCollectionViewLayoutDelegate> timeSpanDelegate;
@end
