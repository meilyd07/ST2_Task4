//
//  MainCollectionViewDelegate.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "MainCollectionViewDelegate.h"
#import "EventCell.h"
#import "QuoterReusableView.h"
#import "DateUtil.h"

@implementation MainCollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCountOfEvents];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    //cell.eventText.text = @"Bla bla bla";
    cell.eventText.text = [self.viewModel getEventTextForRow:indexPath.row];
    cell.eventView.backgroundColor = [UIColor magentaColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    QuoterReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"quoter" forIndexPath:indexPath];
    int minutes = indexPath.item * 15;
    [view setTime:[DateUtil.sharedInstance timeFormatted:minutes]];
    return view;
}

- (NSRange)mainCollectionViewLayout:(MainCollectionViewLayout *)layout timespanForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *start = [self.viewModel getEventStartDateForRow:indexPath.row];
    NSDate *end = [self.viewModel getEventStopDateForRow:indexPath.row];
    
    NSUInteger i = 3600; //start time
    NSUInteger j = 2700; //time interval
    NSRange range = NSMakeRange(i, j);
    return range;
}

@end
