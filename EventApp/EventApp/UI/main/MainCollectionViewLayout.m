//
//  MainCollectionViewLayout.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "MainCollectionViewLayout.h"
#import "MainCollectionViewLayoutDelegate.h"
#import "EventsCollectionView.h"

static const CGFloat CalendarViewLayoutQuoterViewHeight = 35.0f;
static const CGFloat CalendarViewLayoutLeftPadding = 80.0f;
static const CGFloat CalendarViewLayoutRightPadding = 10.0f;
static const CGFloat CalendarViewLayoutTimeLinePadding = 11.0f;
static const int DayQuoters = 97;

@interface MainCollectionViewLayout()
@property (strong, nonatomic) NSMutableArray *cellAttributes;
@property (strong, nonatomic) NSMutableArray *quoterAttributes;
@end

@implementation MainCollectionViewLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.cellAttributes = [NSMutableArray new];
        self.quoterAttributes = [NSMutableArray new];
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, CalendarViewLayoutQuoterViewHeight * DayQuoters + CalendarViewLayoutTimeLinePadding);
}

- (void)prepareLayout
{
    [self.cellAttributes removeAllObjects];
    [self.quoterAttributes removeAllObjects];
    
    if ([((EventsCollectionView *)self.collectionView).timeSpanDelegate conformsToProtocol:@protocol(MainCollectionViewLayoutDelegate)]) {
        id <MainCollectionViewLayoutDelegate> mainCollectionViewLayoutDelegate = (id <MainCollectionViewLayoutDelegate>)((EventsCollectionView *)self.collectionView).timeSpanDelegate;
        
        // Compute every events layoutAttributes
        for (NSInteger i = 0; i < [self.collectionView numberOfSections]; i++) {
            for (NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
                NSIndexPath *cellIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
                NSRange timespan = [mainCollectionViewLayoutDelegate mainCollectionViewLayout:self timespanForCellAtIndexPath:cellIndexPath]; //TO DO
                
//                NSUInteger i = 1800;//TEMPORARY
//                NSUInteger j = 3600;
//                NSRange range = NSMakeRange(i, j);
//                NSRange timespan = range;
                //NSUInteger minutes = i / 60 / 15 * CalendarViewLayoutQuoterViewHeight + CalendarViewLayoutQuoterViewHeight + CalendarViewLayoutTimeLinePadding;
                //CGFloat posY = minutes;//timespan.location / 60.0f + CalendarViewLayoutTimeLinePadding;
                CGFloat posY = timespan.location / 60.0f / 15.0f + CalendarViewLayoutTimeLinePadding;
                CGFloat height = timespan.length / 35.0f;
                
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
                CGRect attributesFrame = attributes.frame;
                attributesFrame.origin = CGPointMake(CalendarViewLayoutLeftPadding, posY);
                attributesFrame.size = CGSizeMake(self.collectionView.bounds.size.width - CalendarViewLayoutLeftPadding - CalendarViewLayoutRightPadding, height);
                attributes.frame = attributesFrame;
                [self.cellAttributes addObject:attributes];
            }
        }
    }
    
    // Compute every 'hour block' layoutAttributes
    for (NSInteger i = 0; i < DayQuoters; i++) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"quoter" withIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGRect attributesFrame = CGRectZero;
        attributesFrame.size = CGSizeMake(self.collectionView.bounds.size.width, CalendarViewLayoutQuoterViewHeight);
        if (i == (DayQuoters - 1)) {
            attributesFrame.size.height += CalendarViewLayoutTimeLinePadding;
        }
        attributesFrame.origin = CGPointMake(0, i * CalendarViewLayoutQuoterViewHeight);
        attributes.frame = attributesFrame;
        [self.quoterAttributes addObject:attributes];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray new];
    
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attributes in self.quoterAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = nil;
    NSInteger index = [self.cellAttributes indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        *stop = [attributes.indexPath isEqual:indexPath];
        return *stop;
    }];
    
    if (index != NSNotFound) {
        attributes = [self.cellAttributes objectAtIndex:index];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = nil;
    NSInteger index = [self.quoterAttributes indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        *stop = [attributes.indexPath isEqual:indexPath];
        return *stop;
    }];
    
    if (index != NSNotFound) {
        attributes = [self.quoterAttributes objectAtIndex:index];
    }
    return attributes;
}


@end
