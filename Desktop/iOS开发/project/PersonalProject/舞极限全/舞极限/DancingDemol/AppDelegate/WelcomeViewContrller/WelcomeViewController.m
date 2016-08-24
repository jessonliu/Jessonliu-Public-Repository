//
//  WelcomeViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/17.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RootViewController.h"
#import "TrainingViewController.h"
#import "BasicNVC.h"
#import "WelcomeViewController.h"
#import "TrainDetailCellDefine.h"

@interface WelcomeViewController () <UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.scrollView.contentSize = CGSizeMake(6 * kScreenWidth, kScreenHeight);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addScrollViewSubImageView];
    [self addPageControl];
}

- (void)addPageControl {
    UIPageControl *pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth / 2, kScreenHeight - 5 * kBaseScale - kMargin, 3 * kBaseScale, 4 * kBaseScale)] autorelease];
    pageControl.numberOfPages = 6;
    pageControl.tag = 200;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self.view addSubview:pageControl];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    RootViewController *rootVC = [[RootViewController alloc] init];
    BasicNVC *navigationVC = [[BasicNVC alloc] initWithRootViewController:rootVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil];
    [rootVC release];
    // 导航条设置图片
    [navigationVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBarBGImage"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    //    默认带有一定透明效果，可以使用以下方法去除系统效果
    [navigationVC.navigationBar setTranslucent:NO];
    [UIApplication sharedApplication].delegate.window.rootViewController = navigationVC;
    NSLog(@"成功跳转");
    [navigationVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addScrollViewSubImageView {
    NSArray *arr = @[@"欢迎来到舞极限", @"美妙的身姿", @"不凡的气质", @"独特的专长", @"让你与众不同", @"爱舞, 一起舞动!"];
    for (int i = 0; i < 6; i++) {
        UIImageView *welcomeView = [[[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 20, kScreenWidth, kScreenHeight - 20)] autorelease];
        welcomeView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d.jpg", i + 5]];
        welcomeView.userInteractionEnabled = YES;
        welcomeView.tag = i + 100;
        
        UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 12 * kBaseScale - kMargin, CGRectGetMaxY(welcomeView.frame) - 6 * kBaseScale, 13 * kBaseScale, 5 * kBaseScale)] autorelease];
        title.text = arr[i];
        title.textColor = [UIColor orangeColor];
        title.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
        [welcomeView addSubview:title];
        [self.scrollView addSubview:welcomeView];
    }
    
    UIImageView *lastImage = (UIImageView *)[self.scrollView viewWithTag:105];
    
    UIButton *enterBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20)] autorelease];
    UILabel *enterLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 10 * kBaseScale - kMargin, CGRectGetMaxY(lastImage.frame) - 9 * kBaseScale, 80 * kBaseScale, 3 * kBaseScale)] autorelease];
    enterLabel.text = @"点击任意进入!";
    [enterBtn addSubview:enterLabel];
    enterLabel.font = [UIFont systemFontOfSize:14];
    enterLabel.textColor = [UIColor whiteColor];
    [enterBtn addTarget:self action:@selector(handleTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    [lastImage addSubview:enterBtn];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:200];
    pageControl.currentPage = scrollView.contentOffset.x / kScreenWidth;
}




- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
@end
