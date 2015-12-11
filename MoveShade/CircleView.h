//
//  CircleView.h
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#define diameter 50

@interface CircleLayer : CALayer

@end

@interface CircleView : UIView
@property (strong, nonatomic) CircleLayer *circleLayer;
@end