//
//  UnderView.h
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecialViewController;


@interface UnderView : UIView
@property (retain, nonatomic) IBOutlet UIButton *healthBtn;
@property (retain, nonatomic) IBOutlet UIButton *makeupBtn;
@property (retain, nonatomic) IBOutlet UIButton *otherBtn;
@property (retain, nonatomic) IBOutlet UIButton *helperBtn;
@property (retain, nonatomic) IBOutlet UIView *hiddenView;
@property (retain, nonatomic) IBOutlet UILabel *lastLabel;

@property (retain, nonatomic) SpecialViewController *viewController;//自身所在的视图控制器

//制造圆角
- (void)cornerRadiusForLabel;

//进入健身专题
- (IBAction)healthAction:(UIButton *)sender;
//进入化妆专题
- (IBAction)makeupAction:(UIButton *)sender;
//进入跳吧专题
- (IBAction)otherAction:(UIButton *)sender;
//进入小贴士专题
- (IBAction)helperAction:(UIButton *)sender;

//小白块动画移动(带弹簧效果)
- (void)labelAnimationToCenter:(CGPoint)center;

//判断小白块(滑块)是否覆盖当前button(frame相等), 如果相等跳转到对应的视图控制器(scrollView滑动)
- (void)isEqualToButton:(UIButton *)sender ToControllerForScrollViewContentOfSet:(CGPoint)contentOfSet;


@end
