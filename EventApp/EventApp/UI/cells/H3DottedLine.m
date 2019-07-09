//
//  H3DottedLine.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "H3DottedLine.h"
#import <UIKit/UIKit.h>

@implementation H3DottedLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* path = [UIBezierPath bezierPath];
    [[UIColor colorWithRed:56.0f/255.0f green:56.0f/255.0f blue:56.0f/255.0f alpha:1.0f] setStroke];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    //[UIColor colorWithRed:56.0f/255.0f green:56.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
    [path setLineWidth:1.0f];
    CGFloat dashes[] = { path.lineWidth, path.lineWidth * 4 };
    [path setLineDash:dashes count:2 phase:0];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
}

@end
