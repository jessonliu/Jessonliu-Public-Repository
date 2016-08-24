//
//  SpecialViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "SpecialViewController.h"
#import "BasicNVC.h"
#import "UnderView.h"
#import "ListViewController.h"
#import "UnderView.h"
#import "UICollectionViewWaterfallLayout.h"
#import "MacroValue.h"
#import "DanceListViewController.h"


#define kWith [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kBtnWidth self.underView.healthBtn.frame.size.width
@interface SpecialViewController ()<UIScrollViewDelegate>

@end

@implementation SpecialViewController


- (void)loadView {
    [super loadView];
    self.scrollView = [[UIScrollView alloc] init];
    //指定代理
    self.scrollView.delegate = self;

    
    //禁止scrollView弹动
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, kHeight-20-44-44-20);
    self.scrollView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, kHeight-20-44-44-20);
    
    
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
    
    //添加各专题视图控制器
    [self addHealthViewController];
    [self addMakeupViewController];
    [self addHelperViewController];
    [self addOtherViewController];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加underView
    self.underView = [[[NSBundle mainBundle] loadNibNamed:@"UnderView" owner:nil options:nil] lastObject];
    self.underView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 85);
    self.underView.viewController = self;
    [self.underView cornerRadiusForLabel];
    [self.view addSubview:self.underView];
}



#pragma mark - 添加四个专题的视图控制器
//添加健康视图控制器
- (void)addHealthViewController {
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    //1.设置每个cell的宽度
    layout.itemWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    //2.设置分区边框范围
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10);
    //3.设置行和列的间距
    layout.minLineSpacing = 10;
    
    self.healthViewController = [[ListViewController alloc] initWithCollectionViewLayout:layout];
   
    //4.设置代理
    layout.delegate = self.healthViewController;
    
    self.healthViewController.specailVC = self;
    [self.healthViewController listviewDidLoadWithID:@"133430" type:self.healthViewController];
    
    [self addChildViewController:self.healthViewController];
    self.healthViewController.view.frame = CGRectMake(0, 0, kWith, kHeight-64-44-20-5);
    [self.scrollView addSubview:self.healthViewController.view];
    [layout release];
    [self.healthViewController release];
}
//添加化妆视图控制器
- (void)addMakeupViewController {
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    //1.设置每个cell的宽度
    layout.itemWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    //2.设置分区边框范围
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10);
    //3.设置行和列的间距
    layout.minLineSpacing = 10;
    
    self.makeupViewController = [[ListViewController alloc] initWithCollectionViewLayout:layout];
    //4.设置代理
    layout.delegate = self.makeupViewController;
    
    self.makeupViewController.specailVC = self;
    [self.makeupViewController listviewDidLoadWithID:@"133393" type:self.makeupViewController];
    
    [self addChildViewController:self.makeupViewController];
    self.makeupViewController.view.frame = CGRectMake(kWith, 0, kWith, kHeight-64-44-20-5);
    [self.scrollView addSubview:self.makeupViewController.view];
    [layout release];
    [self.makeupViewController release];
}
//添加跳吧视图控制器
- (void)addOtherViewController {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的大小 --- item
   layout.itemSize = CGSizeMake((kWith/2)-3, (kWith/2)-5);
    //设置分区的边界距离 (屏幕两侧)
//    layout.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5);
    //设置行与行的间距
    layout.minimumLineSpacing = 8;
    //设置两个item的间距
    layout.minimumInteritemSpacing = 2;

    
    
    DanceListViewController *danceListVC = [[DanceListViewController alloc] initWithCollectionViewLayout:layout];
    
    danceListVC.view.frame = CGRectMake(2*kWith, 0, kWith, kHeight-64-44-20-5);
    [self addChildViewController:danceListVC];
    [self.scrollView addSubview:danceListVC.view];
    [layout release];
    [danceListVC release];
    
    

    
}
//添加小贴士视图控制器
- (void)addHelperViewController {
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    //1.设置每个cell的宽度
    layout.itemWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    //2.设置分区边框范围
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10);
    //3.设置行和列的间距
    layout.minLineSpacing = 10;
    
    self.helperViewController = [[ListViewController alloc] initWithCollectionViewLayout:layout];
    //4.设置代理
    layout.delegate = self.helperViewController;
    
    self.helperViewController.specailVC = self;
    [self.helperViewController listviewDidLoadWithID:@"284097" type:self.helperViewController];

    [self addChildViewController:self.helperViewController];
    self.helperViewController.view.frame = CGRectMake(kWith*3, 0, kWith, kHeight-64-44-20-5);
    [self.scrollView addSubview:self.helperViewController.view];
    [layout release];
    [self.helperViewController release];
}

#pragma mark - scrollView偏移处理
//内容页偏移设置(切换controller)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    CGPoint point2 = self.underView.hiddenView.center;
    point2.x = point.x/4 + self.underView.hiddenView.frame.size.width/2;
    self.underView.hiddenView.center = point2;
    self.scrollView.pagingEnabled = YES;
    
    
//    NSLog(@"%d", (int)point2.x % 80);
    
    if ((int)point.x % (int)kWith == 0) {
        int a = point.x / kWith;
        switch (a) {
            case 0:
                self.underView.lastLabel.text = @"健身";
                break;
            case 1:
                self.underView.lastLabel.text = @"化妆";
                break;
            case 2:
                self.underView.lastLabel.text = @"精舞堂";
                
                break;
            case 3:
                self.underView.lastLabel.text = @"小贴士";
                break;
            default:
                break;
        }
        
    } else {
        self.underView.lastLabel.text = @" ";
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc
{
    self.underView = nil;
    self.healthViewController = nil;
    self.makeupViewController = nil;
    self.helperViewController = nil;
    self.otherViewController = nil;
    self.scrollView = nil;
    [super dealloc];
}

@end
