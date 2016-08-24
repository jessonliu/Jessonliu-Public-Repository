//
//  UnderView.m
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UnderView.h"
#import "SpecialViewController.h"
#import "ListViewController.h"

#define kWith [UIScreen mainScreen].bounds.size.width
@implementation UnderView


//制造圆角
- (void)cornerRadiusForLabel {
    self.lastLabel.layer.cornerRadius = 3;
    self.lastLabel.layer.masksToBounds = YES;
}


//进入健身专题
- (IBAction)healthAction:(UIButton *)sender {
    [self labelAnimationToCenter:sender.center];
    [self isEqualToButton:sender ToControllerForScrollViewContentOfSet:CGPointMake(0, 0)];
    self.viewController.healthViewController.URLID = @"133430";
    
}
//进入化妆专题
- (IBAction)makeupAction:(UIButton *)sender {
    [self labelAnimationToCenter:sender.center];
    [self isEqualToButton:sender ToControllerForScrollViewContentOfSet:CGPointMake(kWith, 0)];
    self.viewController.healthViewController.URLID = @"133393";

}
//进入跳吧专题
- (IBAction)otherAction:(UIButton *)sender {
    [self labelAnimationToCenter:sender.center];
    [self isEqualToButton:sender ToControllerForScrollViewContentOfSet:CGPointMake(kWith*2, 0)];

}
//进入小贴士专题
- (IBAction)helperAction:(UIButton *)sender {
    [self labelAnimationToCenter:sender.center];
    [self isEqualToButton:sender ToControllerForScrollViewContentOfSet:CGPointMake(kWith*3, 0)];
    self.viewController.healthViewController.URLID = @"284097";

}

//小白块动画移动(带弹簧效果)
- (void)labelAnimationToCenter:(CGPoint)center {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.hiddenView.center = center;
    } completion:^(BOOL finished) {
        nil;
    }];
}





//切换到对应的视图控制器, 并改变自身的Label的text
- (void)isEqualToButton:(UIButton *)sender ToControllerForScrollViewContentOfSet:(CGPoint)contentOfSet {
    self.viewController.scrollView.contentOffset = contentOfSet;
    self.lastLabel.text = sender.titleLabel.text;
}



- (void)dealloc {
    self.viewController = nil;
    [_healthBtn release];
    [_makeupBtn release];
    [_otherBtn release];
    [_helperBtn release];
    [_hiddenView release];
    [_lastLabel release];
    [super dealloc];
}
@end
