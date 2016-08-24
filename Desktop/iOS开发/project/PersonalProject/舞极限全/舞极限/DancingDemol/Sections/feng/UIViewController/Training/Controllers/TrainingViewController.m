//
//  TrainingViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/21.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainingViewController.h"
#import "TrainScrollController.h"
#import "TrainTitleModel.h"
#import "TrainTitleDefine.h"
#import "TrainTitleCell.h"
#import "NetWorkManager.h"


@interface TrainingViewController () <UICollectionViewDataSource, UICollectionViewDelegate, TrainScrollControllerDelegate>

@property (nonatomic, retain) NSMutableArray *titleSource; // 存储标题数据源
@property (nonatomic, retain) UIView *whiteBar;

@end

@implementation TrainingViewController

- (void)dealloc
{
    self.whiteBar = nil;
    self.titleSource = nil;
    [super dealloc];
}

- (NSMutableArray *)titleSource {
    if (!_titleSource) {
        self.titleSource = [NSMutableArray arrayWithCapacity:1];
    }
    return [[_titleSource retain] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 网络数据请求解析
    [self getData];
       // 添加标题titleCollecionView
    [self setTitleCollectionView];
}


// 添加标题titleCollecionView
- (void)setTitleCollectionView {
    

    
    // 设置布局管理
    // UICollectionView ---- UITableView的升级版
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell 大小 --- 即item的大小
    flowLayout.itemSize = CGSizeMake(kScreem_Width / 5, 30);
    // 设置两个 item 之间的距离
//    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
//    // 设置分区的边界距离
    flowLayout.sectionInset = UIEdgeInsetsMake( 0, 0, 0, 0);
    // 设置滚动方向
     flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 初始化titleCollectionView 对象
    UICollectionView *titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreem_Width, 30) collectionViewLayout:flowLayout] ;
//    [UIColor colorWithRed:240.0 / 256.0 green:31.0 / 256.0 blue:61.0 / 256.0 alpha:1.0];
    titleCollectionView.backgroundColor = [UIColor colorWithRed:33 / 255.0 green:34 / 255.0 blue:42 / 255.0 alpha:1];
    titleCollectionView.tag = 100;
    // 设置代理
    titleCollectionView.dataSource = self;
    titleCollectionView.delegate = self;
    
    //去掉回弹效果
    titleCollectionView.bounces = NO;
    //去掉水平的滚动条
    titleCollectionView.showsHorizontalScrollIndicator = 0;
    
    // 注册cell
    [titleCollectionView registerClass:[TrainTitleCell class] forCellWithReuseIdentifier:@"reuse"];
  
 
    // 添加到父视图
    [self.view addSubview:titleCollectionView];
    [self whiteBar:titleCollectionView];
    // 释放
    [flowLayout release];
}

// 添加滚动白条
- (void)whiteBar:(UICollectionView *)collectionView {
    self.whiteBar = [[[UIView alloc] init] autorelease];
    self.whiteBar.backgroundColor = [UIColor whiteColor];
    self.whiteBar.frame = CGRectMake(0, 27, kScreem_Width / 5, 3);
    [collectionView addSubview:self.whiteBar];
}




  //添加列表rainScrollView
- (void)addTrainScrollView {
    TrainScrollController *scrollVC = [[TrainScrollController alloc] init];
    scrollVC.delegate = self;
    scrollVC.view.tag = 101;
//    scrollVC.array = self.titleSource;
    [self addChildViewController:scrollVC];
    [self.view addSubview:scrollVC.view];
    [scrollVC getDataArray:self.titleSource];
    [scrollVC release];
}


// 网络数据请求解析
- (void)getData {
    // 创建URL对象
    NSString *urlStr = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/columns?module_id=6944"];
    NetWorkManager *net = [[NetWorkManager alloc] init];
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        
        for (NSDictionary *tempDic in object[@"data"]) {
            // 封装
            TrainTitleModel *trainTitleModel = [TrainTitleModel trainTltleModelWithDictionary:tempDic];
            //        NSLog(@"%@", trainTitleModel.titleID);
            // 添加到title数据源
            [self.titleSource addObject:trainTitleModel];
        }
        // 为数组额外添加 "推荐数组"
        TrainTitleModel *model = [[TrainTitleModel alloc] init];
        model.titleID = @"111111";
        model.name = @"推荐";
        [self.titleSource insertObject:model atIndex:0];
        [model release];
        // 解析完成刷新数据
        
        [(UICollectionView *)[self.view viewWithTag:100] reloadData];
        // 添加滚动视图
        [self addTrainScrollView];
        
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
    



}



#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleSource.count;
}


// 返回 item对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     TrainTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
        [cell configureCellWithModel:self.titleSource[indexPath.item]];
    return cell;
}





#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //CGRectMake(kScreem_Width / 5, 25, kScreem_Width / 5, 5);
    [UIView animateWithDuration:0.5 animations:^{
        self.whiteBar.frame = CGRectMake(indexPath.item * kScreem_Width / 5, 27, kScreem_Width / 5, 3);
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:101];
        scrollView.contentOffset = CGPointMake(indexPath.row * kScreem_Width, 0);
    }];
   
}



#pragma mark -- TrainScrollControllerDelegate

- (void)senderContentOffSize:(CGFloat)xValue {
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //    }); // 延时操作

    [UIView animateWithDuration:1 animations:^{
        CGRect temp = self.whiteBar.frame;
        temp.origin.x = xValue / 5;
        self.whiteBar.frame = temp;
        NSInteger num = xValue / kScreem_Width;
        UICollectionView *collectionView = (UICollectionView *)[self.view viewWithTag:100];
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
