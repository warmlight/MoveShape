//
//  MoveShapeView.m
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//

#import "MoveShapeView.h"
#import "CircleView.h"

#define count 4

@interface MoveShapeView()
@property (assign, nonatomic) CGFloat viewWidth;
@property (assign, nonatomic) CGFloat viewHeight;
@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UIView *secondView;
@property (strong, nonatomic) NSMutableArray *colorArray;

@end

@implementation MoveShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewWidth = self.frame.size.width / count;
        self.viewHeight = self.frame.size.height;
        [self defaultValue];
        [self creatFirstCircleView:[UIColor lightGrayColor]];
        [self hierarchyView];
        [self createTopButtons];
    }
    return self;
}

- (void)defaultValue {
    self.colorArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        UIColor *color = [self randomColor];
        [self.colorArray addObject:color];
    }
}

- (CGRect)createFrame:(NSInteger)index {
    return CGRectMake(index * self.viewWidth, 0, self.viewWidth, self.viewHeight);
}

- (CGRect)createCircleFrame :(NSInteger)index {
    return CGRectMake(index * self.viewHeight + index * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);

}

- (void)creatFirstCircleView:(UIColor *)color{
    for (int i = 0; i < count ; i ++) {
        CGRect frame = [self createFrame:i];
        CircleView *view = [[CircleView alloc] initWithFrame:frame];
        view.circleLayer.backgroundColor = color.CGColor;
        [self addSubview:view];
    }
}

- (void)hierarchyView {
    CGRect firstFrame = CGRectMake((self.viewWidth - self.viewHeight) / 2, 0, self.viewHeight, self.viewHeight);
    self.firstView = [[UIView alloc] initWithFrame:firstFrame];
    self.firstView.layer.cornerRadius = self.viewHeight / 2;
    self.firstView.backgroundColor = [UIColor lightGrayColor];
    self.firstView.clipsToBounds = YES;
    [self addSubview:self.firstView];
    
    self.secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    for (int i= 0; i < count; i ++) {
        CGRect frame = CGRectMake(i * self.viewHeight + i * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
        UIColor *color = self.colorArray[i];
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius = self.viewHeight / 2;
        view.layer.backgroundColor = color.CGColor;
        [self.secondView addSubview:view];
    }
    [self.firstView addSubview:self.secondView];
}

/**
 *  创建按钮
 */
- (void) createTopButtons {
    for (int i = 0; i < count; i ++) {
        CGRect tempFrame = [self createFrame:i];
        UIButton *tempButton = [[UIButton alloc] initWithFrame:tempFrame];
        tempButton.tag = i;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempButton];
    }
}

/**
 *  点击按钮事件
 *
 *  @param sender 点击的相应的按钮
 */
- (void)tapButton:(UIButton *) sender {

    CGRect frame = CGRectMake((self.viewWidth - self.viewHeight) / 2 + self.viewHeight * sender.tag + sender.tag * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
    CGRect changeFrame = CGRectMake(-sender.tag * self.viewHeight + -sender.tag * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
    
    [UIView animateWithDuration:2 animations:^{
        self.firstView.frame = frame;
        self.secondView.frame = changeFrame;
    } completion:^(BOOL finished) {

    }];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
