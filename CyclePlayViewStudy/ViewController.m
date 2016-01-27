//
//  ViewController.m
//  CyclePlayViewStudy
//
//  Created by caiqiujun on 16/1/27.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Frame.h"
#import "CyclePlayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CyclePlayView *loopView = [[CyclePlayView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, 200)];
    [loopView setImages:nil placeholderImages:@[@"img_01.png", @"img_02.png", @"img_03.png", @"img_04.png", @"img_05.png"]];
    [self.view addSubview:loopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
