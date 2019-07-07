//
//  WeekCollectionViewDelegate.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "WeekCollectionViewDelegate.h"
#import "WeekCell.h"

@implementation WeekCollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width/7, 60.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeekCell" forIndexPath:indexPath];
    cell.dayLabel.text = [self.viewModel getWeekDateStringBy:indexPath.row];
    [cell.dotLabel setHidden:YES];//to do add condition
    
    NSArray *arrWeekDaysNames = @[@"ПН",@"ВТ",@"СР",@"ЧТ",@"ПТ",@"СБ",@"ВС"];
    cell.weekDayLabel.text = arrWeekDaysNames[indexPath.row];
    
    if ([self.viewModel isSelected:indexPath.row]) {
        [cell.redView setHidden:NO];
    } else {
        [cell.redView setHidden:YES];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WeekCell *cell = (WeekCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.redView setHidden:NO];
    [self.viewModel selectDateBy:indexPath.row];
    [self.flowDelegate onDateChanged];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}


@end
