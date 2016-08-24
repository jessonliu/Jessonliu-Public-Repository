//
//  navigationView.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "navigationView.h"
#import "WeatherViewController.h"
#import "UIView+ForViewController.h"
#import "BasicNVC.h"
#import "WeatherModel.h"
#import "MacroValue.h"
#import "RootViewController.h"

@interface navigationView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign)BOOL isAppare;

@end

@implementation navigationView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (void)setDataSource:(NSMutableArray *)dataSource {
    if (_dataSource != dataSource) {
        [_dataSource release];
        _dataSource = [dataSource retain];
        [self.iconTableView reloadData];
    }
}




- (UITableView *)iconTableView {
    if (!_iconTableView) {
        
        _iconTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth*0.4, kHeight)];
        self.iconTableView.hidden = YES;
        _iconTableView.delegate = self;
        _iconTableView.dataSource = self;
        _iconTableView.separatorColor= [UIColor clearColor];
        UIImageView *BGView = [[[UIImageView alloc] initWithFrame:_iconTableView.frame] autorelease];
        BGView.image = [UIImage imageNamed:@"picflow_title_bg"];
        _iconTableView.backgroundView = BGView;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forcell) name:@"tongzhi" object:nil];
    }
    return [[_iconTableView retain] autorelease];
}

- (void)forcell {
    _iconTableView.delegate = self;
    _iconTableView.dataSource = self;
    [[self superViewController].view addSubview:self.iconTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseTemp"] autorelease];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



- (IBAction)iconAction:(UIButton *)sender {
    
    
    RootViewController *rootVC = [self superViewController].childViewControllers[0];
    
    
    if (self.isAppare == NO) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.iconTableView.frame = CGRectMake(0, 64, kWidth*0.4, kHeight);
            self.iconTableView.hidden = NO;
            rootVC.view.frame = CGRectMake(kWidth*0.4, 64, kWidth, kHeight-64);
        } completion:^(BOOL finished) {
            nil;
        }];
        self.isAppare = YES;
    } else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.iconTableView.frame = CGRectMake(0, 64, kWidth*0.4, kHeight);
            self.iconTableView.hidden = YES;
            rootVC.view.frame = CGRectMake(0, 64, kWidth, kHeight-64);
            
        } completion:^(BOOL finished) {
            nil;
        }];
        self.isAppare = NO;
    }
    
    
    
}
- (IBAction)weatherAction:(UIButton *)sender {
    WeatherViewController *weatherVC = [[[WeatherViewController alloc] init] autorelease];
    BasicNVC *rootVC = (BasicNVC *)[self superViewController];
    [rootVC pushViewController:weatherVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 9) {
        UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [temp show];
        [temp release];
        
    } else {
        UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"提示" message:@"本功能暂未开放, 敬请期待" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [temp show];
        [temp release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    if (buttonIndex == 1){
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *str = [[NSString new] autorelease];
        BOOL b = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        b ?  (str = @"缓存清除成功") : (str = @"缓存清楚失败");
        UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [temp show];
        [temp release];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
    self.dataSource = nil;
    self.iconTableView = nil;
    [_viewNVC_titileLabel release];
    [_viewNVC_icon_button release];
    [_viewNVC_weather_button release];
    [_viewNVC_weather_image release];
    [_viewNVC_weather_temperature release];
    [_viewNVC_weather_where release];
    [super dealloc];
}
@end