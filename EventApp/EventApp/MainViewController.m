//
//  MainViewController.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/1/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "MainViewController.h"
#import "DateUtil.h"
#import <EventKit/EventKit.h>

@interface MainViewController ()
@property (strong, nonatomic) EKEventStore *eventStore;
@property (nonatomic) BOOL isAccessToEventStoreGranted;
@property (strong, nonatomic) NSMutableArray *todoEvents;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 200)];
    label.text = [DateUtil.sharedInstance getCurrentDate];
    [self.view addSubview:label];
    [self updateAuthorizationStatusToAccessEventStore];
}

- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (void)updateAuthorizationStatusToAccessEventStore {
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (authorizationStatus) {
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted: {
            self.isAccessToEventStoreGranted = NO;
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Access Denied"
//                                                                message:@"This app doesn't have access to your Reminders." delegate:nil
//                                                      cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertView show];
            //[self.tableView reloadData];
            NSLog(@"This app doesn't have access to your Reminders.");
            break;
        }
            
            // 4
        case EKAuthorizationStatusAuthorized:
            self.isAccessToEventStoreGranted = YES;
            NSLog(@"This app has access");
            //[self.tableView reloadData];
            break;
            
            // 5
        case EKAuthorizationStatusNotDetermined: {
            __weak MainViewController *weakSelf = self;
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder
                                            completion:^(BOOL granted, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    weakSelf.isAccessToEventStoreGranted = granted;
                                                    //[weakSelf.tableView reloadData];
                                                });
                                            }];
            break;
        }
    }
}


@end
