//
//  MainViewController.h
//  EventApp
//
//  Created by Hanna Rybakova on 7/1/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"
#import "OnDateChangedProtocolDelegate.h"

@interface MainViewController : UIViewController <OnDateChangedProtocolDelegate>
@property (strong, nonatomic) MainViewModel *viewModel;
@end

