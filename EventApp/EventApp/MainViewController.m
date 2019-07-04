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
#import "WeekCell.h"
#import "CalendarModel.h"

@interface MainViewController ()
@property (strong, nonatomic) EKEventStore *eventStore;
@property (nonatomic) BOOL isAccessToEventStoreGranted;
@property (strong, nonatomic) NSMutableArray *todoEvents;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) CalendarModel *model;
@property (strong, nonatomic) NSMutableArray *weekData;
@end

@implementation MainViewController

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeekCell" forIndexPath:indexPath];
    cell.dayLabel.text = [DateUtil.sharedInstance getDateNumber:self.weekData[indexPath.row]];
    [cell.dotLabel setHidden:YES];//to do add condition
    
    NSArray *arrWeekDaysNames = @[@"ПН",@"ВТ",@"СР",@"ЧТ",@"ПТ",@"СБ",@"ВС"];
    cell.weekDayLabel.text = arrWeekDaysNames[indexPath.row];
    
    return cell;
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width/7, 60.0f);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160.0f) collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.view addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:@"WeekCell" bundle:nil] forCellWithReuseIdentifier:@"WeekCell"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:3.0f/255.0f green:117.0f/255.0f blue:148.0f/255.0f alpha:1.0f];
    [self addCollectionViewConstraints];
}

- (void)addCollectionViewConstraints {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0].active = YES;
    [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
                                                      constant:0].active = YES;
    [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
                                                      constant:0].active = YES;
    [self.collectionView.heightAnchor constraintEqualToConstant:60].active = YES;

}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.view.frame.size.width/7, 60.0f);
    [layout invalidateLayout];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/7, 60.0f);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAuthorizationStatusToAccessEventStore];
    self.model = [CalendarModel new];
    self.weekData = [self.model arrayOfDates: [NSDate date]];
    [self setupNavigationBar];
    [self createCollectionView];
}

- (void)setupNavigationBar {
    self.title = [DateUtil.sharedInstance getCurrentDate];
    UIFont *font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:font}];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:font}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:3.0f/255.0f green:117.0f/255.0f blue:148.0f/255.0f alpha:1.0f]];
    }

- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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
