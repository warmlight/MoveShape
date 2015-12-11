//
//  CircleView.m
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//



#import "CircleView.h"

@implementation CircleLayer
- (instancetype)init:(CGSize)size{
    self = [super init];
    if (self) {
        self.cornerRadius = size.height / 2;
    }
    return self;
}

@end



@implementation CircleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.circleLayer = [[CircleLayer alloc] init:CGSizeMake(diameter, diameter)];
        self.circleLayer.frame = CGRectMake((frame.size.width - diameter) / 2, (frame.size.height - diameter) / 2, diameter, diameter);
        [self.layer addSublayer:self.circleLayer];
        
    }
    return self;
}
@end