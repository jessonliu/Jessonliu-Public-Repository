//
//  RootViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/21.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "RootViewController.h"
#import "TrainingViewController.h"
#import "SpecialViewController.h"
#import "DancingViewController.h"
#import "PerformanceViewController.h"
#import "DiscoverViewController.h"
#import "BasicNVC.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewControllers = @[
                             [self addTrainController],
                             [self addPerformanceController],
                             [self addDancingCircleController],
                             [self addDiscoverController],
                             [self addSpecialController]
                             ];
  
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBGImage"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:240.0 / 256.0 green:31.0 / 256.0 blue:61.0 / 256.0 alpha:1.0];
    
    
    
}


// 训练界面
- (TrainingViewController *)addTrainController {
    TrainingViewController *trainVC = [[TrainingViewController alloc] init] ;
    trainVC.tabBarItem.title = @"爱舞";
    trainVC.tabBarItem.image = [UIImage imageNamed:@"module_6944@2x"];
    
    return [trainVC autorelease];
}

// 表演界面
- (PerformanceViewController *)addPerformanceController {
    PerformanceViewController *performanceVC = [[[PerformanceViewController alloc] init] autorelease];
    performanceVC.tabBarItem.title = @"精彩表演";
//    performanceVC.view.backgroundColor = [UIColor cyanColor];
    performanceVC.tabBarItem.image = [UIImage imageNamed:@"dd_sh_submit_video@2x"];
    return performanceVC;
    
}

// 发现界面
- (DiscoverViewController *)addDiscoverController {
    DiscoverViewController *discoverVC = [[[DiscoverViewController alloc] init] autorelease];
//    discoverVC.view.backgroundColor = [UIColor yellowColor];
    discoverVC.tabBarItem.title = @"发现";
    discoverVC.tabBarItem.image = [UIImage imageNamed:@"uc_user_favor"];
    return discoverVC;
}


// 舞蹈圈界面
- (DancingViewController *)addDancingCircleController {
    DancingViewController *danceVC = [[[DancingViewController alloc] init] autorelease];
    danceVC.tabBarItem.title = @"舞蹈圈";
    danceVC.tabBarItem.image = [UIImage imageNamed:@"module_12290@2x"];
//    danceVC.view.backgroundColor = [UIColor purpleColor];
    return danceVC;
}


// 专题界面
- (SpecialViewController *)addSpecialController {
    SpecialViewController *specialVC = [[[SpecialViewController alloc] init] autorelease];
//    specialVC.view.backgroundColor = [UIColor blackColor];
    specialVC.tabBarItem.title = @"专题";
    specialVC.tabBarItem.image = [UIImage imageNamed:@"module_12288@2x"];
    return specialVC;
}


#pragma mark -- UITabBarController
// 当选中标签时触发
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //    self.navigationItem.title = item.title;
    BasicNVC *nvc = (BasicNVC *)self.navigationController;
    nvc.viewNVC.viewNVC_titileLabel.text = item.title;
    
    [nvc.navigationBar.subviews enumerateObjectsUsingBlock:^( UIView * obj, NSUInteger idx, BOOL * stop) {
        if ([obj isKindOfClass:[navigationView class]] && self.view.frame.origin.x != 0) {
            UIButton *button = (UIButton *)[(navigationView *)obj viewWithTag:201];
            [(navigationView *)obj iconAction:button];
        }
    }];;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end