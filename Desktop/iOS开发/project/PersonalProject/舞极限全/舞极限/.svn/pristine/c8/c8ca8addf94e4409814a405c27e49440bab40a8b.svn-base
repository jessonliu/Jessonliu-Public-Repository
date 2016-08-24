//
//  UIView+ForViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UIView+ForViewController.h"

@implementation UIView (ForViewController)


- (UIViewController *)superViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
