//
//  DetailWeatherView.h
//  DancingDemol
//
//  Created by laouhn on 15/10/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWeatherView : UIView
@property (retain, nonatomic) IBOutlet UILabel *pm2_5Value;//pm2.5值
@property (retain, nonatomic) IBOutlet UILabel *weekDate;//周几
@property (retain, nonatomic) IBOutlet UILabel *temp;//温度
@property (retain, nonatomic) IBOutlet UILabel *wearher;//天气情况
@property (retain, nonatomic) IBOutlet UILabel *wind;//风向
@property (retain, nonatomic) IBOutlet UILabel *moisture;//湿度
@property (retain, nonatomic) IBOutlet UILabel *sunshineStrong;//紫外线强度
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;//天气头像

@property (retain, nonatomic) IBOutlet UIVisualEffectView *pm2_5View;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;


- (void)cornerRadius:(CGFloat)radius;

@end
