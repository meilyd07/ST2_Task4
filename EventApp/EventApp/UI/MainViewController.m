//
//  MainViewController.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/1/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "MainViewController.h"
#import <EventKit/EventKit.h>
#import "MainCollectionViewLayout.h"
#import "WeekCollectionViewDelegate.h"

@interface MainViewController ()
@property (strong, nonatomic) EKEventStore *eventStore;
@property (nonatomic) BOOL isAccessToEventStoreGranted;
@property (strong, nonatomic) NSMutableArray *todoEvents;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionView *mainCollectionView;
@property (strong, nonatomic) WeekCollectionViewDelegate *weekDelegate;
@end

@implementation MainViewController

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width/7, 60.0f);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160.0f) collectionViewLayout:layout];
    
    self.weekDelegate = [WeekCollectionViewDelegate new];
    self.weekDelegate.flowDelegate = self;
    self.weekDelegate.viewModel = self.viewModel;
    
    [self.collectionView setDataSource:self.weekDelegate];
    [self.collectionView setDelegate:self.weekDelegate];
    [self.view addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:@"WeekCell" bundle:nil] forCellWithReuseIdentifier:@"WeekCell"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:3.0f/255.0f green:117.0f/255.0f blue:148.0f/255.0f alpha:1.0f];
    [self addCollectionViewConstraints];
}

//- (void)createMainCollectionView {
//    MainCollectionViewLayout *layout = [MainCollectionViewLayout new];
//    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
//    self.mainCollectionView.dataSource = self;
//    self.mainCollectionView.delegate = self;
//    [self addMainCollectionViewConstraints];
//}
//
//- (void)addMainCollectionViewConstraints {
//
//}

- (void)addCollectionViewConstraints {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0].active = YES;
    } else {
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0].active = YES;
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAuthorizationStatusToAccessEventStore];
    [self.viewModel loadWeek];
    [self setNavigationBarTitle];
    [self createCollectionView];
    [self addLeftSwipe];
    [self addRightSwipe];
}

-(void)addRightSwipe {
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:swiperight];}

-(void)addLeftSwipe {
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:swipeleft];
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self swipeByCount:7];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self swipeByCount:-7];
}

-(void)swipeByCount:(int)days {
    [self.viewModel loadWeekByCount:days];
    [self onDateChanged];
}

- (void)setNavigationBarTitle {
    self.title = [self.viewModel getSelectedDateFormatted];
}

- (void)onDateChanged {
    [self.collectionView reloadData];
    [self setNavigationBarTitle];
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
    self.navigationController.navigationBar.translucent = NO;
}

- (void)updateAuthorizationStatusToAccessEventStore {
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (authorizationStatus) {
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted: {
            self.isAccessToEventStoreGranted = NO;
            //[self.tableView reloadData];
            NSLog(@"This app doesn't have access to your Reminders.");
            break;
        }
        case EKAuthorizationStatusAuthorized:
            self.isAccessToEventStoreGranted = YES;
            NSLog(@"This app has access");
            //[self.tableView reloadData];
            break;
            
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
