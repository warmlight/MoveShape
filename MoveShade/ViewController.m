//
//  ViewController.m
//  MoveShade
//
//  Created by yiban on 15/12/10.
//  Copyright © 2015年 yiban. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "MoveShapeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MoveShapeView *shapeView = [[MoveShapeView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, diameter)];
    [self.view addSubview:shapeView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
