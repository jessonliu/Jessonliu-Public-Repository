//
//  BasicNVC.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "BasicNVC.h"
#import "WeatherModel.h"
#import "WeatherManager.h"
#import "UIImageView+Cache.h"
#import "WeatherViewController.h"
#import "MacroValue.h"
#import "TrainDetailViewController.h"


@interface BasicNVC ()

@property (nonatomic, assign)NSInteger a;

@end

@implementation BasicNVC





- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:NO];
    self.a ++;
    if (self.a != 1) {
        self.viewNVC.hidden = YES;
        
        self.titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*kOneWidth5s, 32*kOneHeight5s, 100*kOneWidth5s, 20*kOneHeight5s)];
        self.titileLabel.textAlignment = NSTextAlignmentCenter;
        self.titileLabel.font = [UIFont systemFontOfSize:21 weight:5];
        self.titileLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:self.titileLabel];
        [self.titileLabel release];
        
    }
    if ([viewController isKindOfClass:[WeatherViewController class]]) {
        ((WeatherViewController *)viewController).weatherModel = self.weatherModel;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.titileLabel.hidden = YES;
    if (self.childViewControllers.count == 2) {
        self.viewNVC.hidden = NO;
    }
    [self.childViewControllers enumerateObjectsUsingBlock:^( UIViewController *  obj, NSUInteger idx, BOOL * stop) {
        if ([obj isKindOfClass:[TrainDetailViewController class]]) {
            [((TrainDetailViewController *)obj).dancePlayer replaceCurrentItemWithPlayerItem:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:(TrainDetailViewController *)obj name:@"SendVideoURLStr" object:nil];
        }
    }];
    
    
    
    
    return  [super popViewControllerAnimated:NO];
}

- (void)loadView {
    [super loadView];
    
    //------改变左上角天气信息
    [WeatherManager getWeatherModelSuccess:^(WeatherManager *manager, NSArray *arr) {
        NSDictionary *dic = arr[0];
        self.weatherModel = [[DetailWeather new] autorelease];
        [self.weatherModel setValuesForKeysWithDictionary:dic];
        
        self.viewNVC.viewNVC_weather_where.text = self.weatherModel.name;
        self.viewNVC.viewNVC_weather_temperature.text = self.weatherModel.temp;
        [self.viewNVC.viewNVC_weather_image JF_setImageWithURL:self.weatherModel.iconImageView placeHolderImage:@"default_indexpic_2x.png"];
        [self.viewNVC.viewNVC_weather_image JF_setImageWithURL:self.weatherModel.iconImageView placeHolderImage:@"default_indexpic_2x.png"];
        } fail:^(WeatherManager *manager, NSError *error) {
        nil;
    }];
    
}








- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewNVC = [[[NSBundle mainBundle] loadNibNamed:@"navigationView" owner:nil options:nil] firstObject];
    self.viewNVC.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    [self.navigationBar addSubview:self.viewNVC];
    
    self.viewNVC.dataSource = [@[@"登陆", @"个人资料", @"我的消息", @"我的收藏", @"我的帖子", @"我关注的", @"关于我们", @"提交反馈", @"设置", @"清除缓存"] mutableCopy];
    
    
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
    self.titileLabel = nil;
    self.weatherModel = nil;
    self.model = nil;
    self.viewNVC = nil;
    [super dealloc];
}

@end