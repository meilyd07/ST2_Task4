//
//  QuoterReusableView.m
//  EventApp
//
//  Created by Hanna Rybakova on 7/8/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "QuoterReusableView.h"
#import "H3DottedLine.h"

@interface QuoterReusableView()
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) H3DottedLine *timeLineView;
@end

@implementation QuoterReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.timeLabel = [UILabel new];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        self.timeLabel.textColor = [UIColor colorWithRed:56.0f/255.0f green:56.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        
        self.timeLineView = [H3DottedLine new];
        [self addSubview:self.timeLineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect timeLabelFrame = self.timeLabel.frame;
    timeLabelFrame.origin.x = 2;
    timeLabelFrame.origin.y = 15;
    timeLabelFrame.size.width = 60;
    self.timeLabel.frame = timeLabelFrame;
 
    CGRect timeLineFrame = CGRectMake(10.0f, 6.0f, self.bounds.size.width - 20, 0.5f);
    self.timeLineView.frame = timeLineFrame;
    self.timeLineView.backgroundColor = [UIColor clearColor];
}

- (void)setTime:(NSString *)time
{
    self.timeLabel.text = time;
    [self.timeLabel sizeToFit];
    [self setNeedsLayout];
}
@end
