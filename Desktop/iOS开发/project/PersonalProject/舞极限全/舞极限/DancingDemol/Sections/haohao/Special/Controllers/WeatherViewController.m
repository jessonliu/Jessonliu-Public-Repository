//
//  WeatherViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#define kWith [UIScreen mainScreen].bounds.size.width

#import "WeatherViewController.h"
#import "UIImageView+Cache.h"
#import "NSDate+TodayWeek.h"
#import "MacroValue.h"
#import "BasicNVC.h"



@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.weatherView = [[[NSBundle mainBundle] loadNibNamed:@"DetailWeatherView" owner:nil options:nil] lastObject];
    
    self.weatherView.scrollView.contentSize = CGSizeMake(kWith, 700*kOneHeight5s);
    self.weatherView.scrollView.showsVerticalScrollIndicator = NO;
    
    self.weatherView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.weatherView];
    
    self.weatherView.pm2_5View.frame = CGRectMake(220*kOneWidth5s, 40*kOneHeight5s, 90*kOneWidth5s, 80*kOneHeight5s);
    
    
    //给天气详情界面的各个控件赋值
    [self changeEveryValue];
    //添加6大指数
    [self addZSView];
    
}

//添加6大指数
- (void)addZSView {
    
    NSArray *imageArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:[UIImage imageNamed:@"weather_index_dress"], [UIImage imageNamed:@"weather_index_car_washing"], nil], [NSArray arrayWithObjects:[UIImage imageNamed:@"weather_index_drying"], [UIImage imageNamed:@"weather_index_sports"], nil], [NSArray arrayWithObjects:[UIImage imageNamed:@"weather_index_umbrella"], [UIImage imageNamed:@"weather_index_uvi"], nil], nil];

    
    for (int y = 0; y < 3; y++) {
        for (int x = 0; x < 2; x++) {
            //错放对应指数信息的model
            ZSModel *zsmodel = self.weatherModel.ZSArray[2*y+x];
            
            UIImageView *bgView = [[UIImageView alloc] init];
            bgView.frame = CGRectMake(7*kOneWidth5s+ x*160*kOneWidth5s, 350*kOneHeight5s + y*(88*kOneHeight5s), 145*kOneWidth5s, 80*kOneHeight5s );
            
            //添加指数图片
            UIImageView *iconView = [[UIImageView alloc] initWithImage:imageArray[y][x]];
            iconView.frame = CGRectMake(-5*kOneWidth5s, 0, 75*kOneWidth5s, 80*kOneHeight5s);
            [bgView addSubview:iconView];
            [iconView release];
            //添加指数名字
            UILabel *nameLbel = [[UILabel alloc] initWithFrame:CGRectMake(75*kOneWidth5s, 10*kOneHeight5s, 55*kOneWidth5s, 35*kOneHeight5s)];
            nameLbel.font = [UIFont systemFontOfSize:13];
            nameLbel.lineBreakMode = 1;
            nameLbel.numberOfLines = 0;
            nameLbel.textColor = [UIColor whiteColor];
            nameLbel.text = zsmodel.name;
            [bgView addSubview:nameLbel];
            [nameLbel release];
            
            
            //添加指数信息
            UILabel *msgLbel = [[UILabel alloc] initWithFrame:CGRectMake(75*kOneWidth5s, 45*kOneHeight5s, 48*kOneWidth5s, 20*kOneHeight5s)];
            msgLbel.font = [UIFont systemFontOfSize:13];
            msgLbel.textColor = [UIColor whiteColor];
            msgLbel.text = zsmodel.hint;
            msgLbel.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:msgLbel];
            [msgLbel release];
            
            
            [self.weatherView.scrollView addSubview:bgView];
            [bgView release];
        }
    }
}
 
 
 
//给天气详情界面的各个控件赋值
- (void)changeEveryValue {
    
    [self.weatherView cornerRadius:30];
    
    ((BasicNVC *)self.navigationController).titileLabel.text = self.weatherModel.name;
    
    self.weatherView.pm2_5Value.text = (NSString *)self.weatherModel.pm25Data.pm2_5;
    self.weatherView.temp.text = self.weatherModel.temp;
    [self.weatherView.iconImageView JF_setImageWithURL:self.weatherModel.iconImageView placeHolderImage:@"default_indexpic_2x.png"];
    self.weatherView.sunshineStrong.text = self.weatherModel.zwx;
    self.weatherView.wind.text = self.weatherModel.fx;
    self.weatherView.moisture.text = self.weatherModel.sd;
    self.weatherView.wearher.text = self.weatherModel.report;
    self.weatherView.weekDate.text = [NSDate TodayForWeek];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc
{
    self.weatherView = nil;
    self.city = nil;
    self.weatherModel = nil;
    [super dealloc];
}

@end
