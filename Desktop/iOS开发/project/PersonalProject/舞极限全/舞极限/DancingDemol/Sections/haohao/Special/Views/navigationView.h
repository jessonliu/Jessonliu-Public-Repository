//
//  navigationView.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navigationView : UIView

@property (retain, nonatomic) IBOutlet UIButton *viewNVC_icon_button;//导航条人物头像
@property (retain, nonatomic) IBOutlet UIButton *viewNVC_weather_button;//导航条天气(只提供一个点击事件)
@property (retain, nonatomic) IBOutlet UIImageView *viewNVC_weather_image;//导航条天气的图标显示
@property (retain, nonatomic) IBOutlet UILabel *viewNVC_weather_temperature;//导航条天气的温度显示
@property (retain, nonatomic) IBOutlet UILabel *viewNVC_weather_where;//导航条天气的当前城市显示
@property (retain, nonatomic) IBOutlet UILabel *viewNVC_titileLabel;//导航条标题内容



- (IBAction)iconAction:(UIButton *)sender;

@property (nonatomic, retain)NSMutableArray *dataSource;
@property (nonatomic, retain)UITableView *iconTableView;

@end
