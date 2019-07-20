//
//  MainCollectionViewDelegate.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCollectionViewLayout.h"
#import "MainCollectionViewLayoutDelegate.h"
#import "MainViewModel.h"

@interface MainCollectionViewDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MainCollectionViewLayoutDelegate>
@property (weak, nonatomic) MainViewModel *viewModel;
@end
