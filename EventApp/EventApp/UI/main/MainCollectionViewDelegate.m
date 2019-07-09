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
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    cell.eventText.text = @"Bla bla bla";
    cell.eventView.backgroundColor = [UIColor magentaColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    QuoterReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"quoter" forIndexPath:indexPath];
    int minutes = indexPath.item * 15;
    [view setTime:[DateUtil.sharedInstance timeFormatted:minutes]];
    return view;
}

@end
