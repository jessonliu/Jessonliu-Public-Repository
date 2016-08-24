//
//  SpecialViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListViewController;
@class UnderView;

@interface SpecialViewController : UIViewController

@property (nonatomic, retain)UIScrollView* scrollView;

@property (nonatomic, retain)ListViewController *healthViewController;//健康专题视图控制器
@property (nonatomic, retain)ListViewController *makeupViewController;//化妆专题视图控制器
@property (nonatomic, retain)ListViewController *otherViewController;//跳吧专题视图控制器
@property (nonatomic, retain)ListViewController *helperViewController;//小贴士视图控制器


@property (nonatomic, retain)UnderView *underView;//导航条下面的四个button所在的视图

@end
