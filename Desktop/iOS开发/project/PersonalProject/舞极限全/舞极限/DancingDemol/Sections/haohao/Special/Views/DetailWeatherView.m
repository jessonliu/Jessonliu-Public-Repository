//
//  DetailWeatherView.m
//  DancingDemol
//
//  Created by laouhn on 15/10/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DetailWeatherView.h"

@implementation DetailWeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)cornerRadius:(CGFloat)radius {
    self.pm2_5View.layer.cornerRadius = radius;
    self.pm2_5View.layer.masksToBounds = YES;
}


- (void)dealloc {
    [_pm2_5Value release];
    [_weekDate release];
    [_temp release];
    [_wearher release];
    [_wind release];
    [_moisture release];
    [_sunshineStrong release];
    [_iconImageView release];
    [_pm2_5View release];
    [_scrollView release];
    [super dealloc];
}
@end
