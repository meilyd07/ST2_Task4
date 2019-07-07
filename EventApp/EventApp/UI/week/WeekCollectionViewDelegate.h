//
//  WeekCollectionViewDelegate.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"
#import "OnDateChangedProtocolDelegate.h"

@interface WeekCollectionViewDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) MainViewModel *viewModel;
@property (nonatomic, weak) id<OnDateChangedProtocolDelegate> flowDelegate;
@end
