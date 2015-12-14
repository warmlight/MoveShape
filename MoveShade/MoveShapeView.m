//
//  MoveShapeView.m
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//

#import "MoveShapeView.h"

#define count 5

@interface MoveShapeView()
@property (assign, nonatomic) CGFloat        viewWidth;
@property (assign, nonatomic) CGFloat        viewHeight;
@property (strong, nonatomic) UIView         *secondView;
@property (strong, nonatomic) UIView         *thirdView;
@property (strong, nonatomic) NSMutableArray *colorArray;

@end

@implementation MoveShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewWidth  = self.frame.size.width / count;
        self.viewHeight = self.frame.size.height;
        [self colorValue];
        [self creatCircleView:[UIColor lightGrayColor]];
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

//第一层
- (void)creatCircleView:(UIColor *)color{
    for (int i = 0; i < count ; i ++) {
        CGRect frame               = [self createCircleFrame:i];
        UIColor *color             = [UIColor lightGrayColor];
        UIView *view               = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius    = self.viewHeight / 2;
        view.layer.backgroundColor = color.CGColor;
        [self addSubview:view];

    }
}

//第二层 第三层
- (void)hierarchyView {
    CGRect firstFrame                  = [self createCircleFrame:0];
    self.secondView                    = [[UIView alloc] initWithFrame:firstFrame];
    self.secondView.layer.cornerRadius = self.viewHeight / 2;
    self.secondView.backgroundColor    = [UIColor lightGrayColor];
    self.secondView.clipsToBounds      = YES;                   //subView超过它的范围的部分不显示
    [self addSubview:self.secondView];
    
    self.thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    for (int i= 0; i < count; i ++) {
        CGRect frame               = CGRectMake(i * self.viewHeight + i * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
        UIColor *color             = self.colorArray[i];
        UIView *view               = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius    = self.viewHeight / 2;
        view.layer.backgroundColor = color.CGColor;
        
        UILabel *textLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewHeight, self.viewHeight)];
        textLabel.backgroundColor  = [UIColor clearColor];
        textLabel.text             = @"mm";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        [view addSubview:textLabel];
        
        [self.thirdView addSubview:view];
    }
    [self.secondView addSubview:self.thirdView];
}

- (void)createTopButtons {
    for (int i = 0; i < count; i ++) {
        CGRect tempFrame     = CGRectMake(i * self.viewWidth, 0, self.viewWidth, self.viewHeight);
        UIButton *tempButton = [[UIButton alloc] initWithFrame:tempFrame];
        tempButton.tag       = i;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempButton];
    }
}

- (void)tapButton:(UIButton *) sender {

    CGRect frame       = [self createCircleFrame:sender.tag];
    CGRect changeFrame = CGRectMake(-sender.tag * self.viewHeight + -sender.tag * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
    
    [UIView animateWithDuration:2 animations:^{
        self.secondView.frame = frame;
        self.thirdView.frame  = changeFrame;
    } completion:^(BOOL finished) {

    }];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
