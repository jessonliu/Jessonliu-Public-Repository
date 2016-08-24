


//
//  DancingViewController.m
//  DancingDemol
//
//  Created by lanouhn on 15/10/10.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DancingViewController.h"
#import "DancingViewCell.h"
#import "NetWorkManager.h"
#import "DancingCellModel.h"
#import "MJRefresh.h"
@interface DancingViewController ()

@property (nonatomic, retain) NSMutableArray *dataSource;//存储数组
@property (nonatomic, assign) CGFloat heightA;
@property (nonatomic, assign) NSInteger start;
@end

@implementation DancingViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.start = 0;
    //将不可变数组拷贝成可变数组, 并且是深拷贝
    self.dataSource = [@[] mutableCopy];
    //隐藏导航栏
//    self.navigationController.navigationBarHidden = NO;
//布局headerView
[self layoutHeaderView];
//布局tableView
[self layoutTableView];
//请求数据
[self getData];
}
- (void)getData {
    
    [[[NetWorkManager alloc] init] getDataWithURLString:[NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/seekhelp/949/latest_comment?&start=%@&count=20", @(self.start)] success:^(NetWorkManager *net, id object) {
//         解析数据
                [self parserDataWithObject:object];
    } fialBlock:^(NetWorkManager *net, NSError *error) {
         NSLog(@"%@", error);
    }];
}
//解析数据
- (void)parserDataWithObject:(NSDictionary *)object {
    if (self.start == 0) {
        [self.dataSource removeAllObjects];
    }
    for (NSDictionary *dict in object[@"data"][@"content"]) {
        DancingCellModel *model = [[[DancingCellModel alloc] initWithDic:dict] autorelease];
        [self.dataSource addObject:model];
    }
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.tableView reloadData];
}
//布局headerView
- (void)layoutHeaderView {
    CGFloat kBase = [UIScreen mainScreen].bounds.size.height / 32;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10.0 * kBase)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:headerView.frame];
    imageV.image = [UIImage imageNamed:@"WuDanceCircle.png"];
    //    imageV.frame = headerView.frame;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"舞蹈圈左边"]];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageY = 10 *kBase - 40;
    imageView.frame = CGRectMake(screenWidth - 20 - 30, imageY, 30, 30);
    
    UILabel *danceL = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 70 -30, imageY, 45, 30)];
    danceL.text = @"舞蹈圈";
    danceL.textColor = [UIColor whiteColor];
    danceL.font = [UIFont systemFontOfSize:14];
    
    UILabel *topicL = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 150, imageY + 5, 50, 20)];
    topicL.text = @"话题3895";
    topicL.textColor = [UIColor whiteColor];
    topicL.font = [UIFont systemFontOfSize:10];
    
    [headerView addSubview:imageV];
    [imageV addSubview:imageView];
    [imageV addSubview:danceL];
    [imageV addSubview:topicL];
    
    
    self.tableView.tableHeaderView = headerView;
    [headerView release];
    [imageV release];
    [imageView release];
    [danceL release];
    [topicL release];
    
}
//布局tableView
- (void)layoutTableView {
    //注册cell
    //    [self.tableView registerClass:[DancingViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //添加上拉加载, 下拉刷新
    [self addRefreshAndLoadMore];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark — MJRefresh
- (void)addRefreshAndLoadMore {
    //添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(handleRefresh)];
    //添加上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(hanleLoadMore)];
}

//下拉刷新
- (void)handleRefresh {
    //下拉刷新
    //1. 参数重新设置为初始值
    self.start = 0;
    //2. 调用请求数据的方法
    [self getData];
}

//上拉加载
- (void)hanleLoadMore {
    //1. 请求下一页数据的参数
    self.start += 20;
    //2. 调用请求数据的方法
    [self getData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DancingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld", indexPath.row]];
    if (!cell) {
        cell = [[[DancingViewCell alloc] init] autorelease];
    }
    //关闭cell的选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    self.heightA = [cell returnCellHeigt];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.heightA;
}


- (void)dealloc
{
    self.dataSource =nil;
    [super dealloc];
}

@end