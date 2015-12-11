//
//  MoveShapeView.m
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//

#import "MoveShapeView.h"

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
        [self colorValue];
        [self creatFirstCircleView:[UIColor lightGrayColor]];
        [self hierarchyView];
        [self createTopButtons];
    }
    return self;
}

- (void)colorValue {
    self.colorArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        UIColor *color = [self randomColor];
        [self.colorArray addObject:color];
    }
}

- (CGRect)createCircleFrame :(NSInteger)index {
    return CGRectMake((self.viewWidth - self.viewHeight) / 2 + index * (self.viewWidth - self.viewHeight) + index * self.viewHeight, 0, self.viewHeight, self.viewHeight);
}

- (void)creatFirstCircleView:(UIColor *)color{
    for (int i = 0; i < count ; i ++) {
        CGRect frame = [self createCircleFrame:i];
        UIColor *color = [UIColor lightGrayColor];
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius = self.viewHeight / 2;
        view.layer.backgroundColor = color.CGColor;
        [self addSubview:view];

    }
}

- (void)hierarchyView {
    CGRect firstFrame = [self createCircleFrame:0];
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
        CGRect tempFrame = CGRectMake(i * self.viewWidth, 0, self.viewWidth, self.viewHeight);
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

    CGRect frame = [self createCircleFrame:sender.tag];
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
