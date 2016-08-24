//
//  TrainListController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainListController.h"
#import "TrainViewCell.h"
#import "NetWorkManager.h"
#import "TrainDetailCellDefine.h"
#import "TrainDetailViewController.h"
#import "TrainDetailModel.h"
#import "SingleTon.h"
#import "DanceViewTableViewController.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"


@interface TrainListController ()

@property (nonatomic, assign) NSInteger start;

@end

@implementation TrainListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:1];

    // 网络数据求情解析
//    [self getDataWithURLString:self.titID];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32 * kBaseScale, (568 - 94 - 44) * kBaseScale / 10)];
    imageView.image = [UIImage imageNamed:@"空白背景.png"];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    [view addSubview:imageView];
    self.tableView.backgroundView = view;
    
    
    // 注册cell
    [self layoutTabView];
}


// 注册cell
- (void)layoutTabView {
    // 1.注册Cell
    [self.tableView registerClass:[TrainViewCell class] forCellReuseIdentifier:@"reuse"];
    // 3.设置分割线的样式
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self addRefreshAndLoadMore];
}

#pragma mark - Table view data source
// 返回cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
//    NSLog(@"%ld", self.dataArray.count);
    [cell configureCellWithModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMarginTop_downTitle;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([((TrainListModel *)self.dataArray[indexPath.row]).contentType isEqualToString:@"livmedia"]) {
        TrainDetailViewController *detainVC = [[TrainDetailViewController alloc] init];
        detainVC.listModel = self.dataArray[indexPath.row];
        NSLog(@"%@", self.dataArray[indexPath.row]);
        detainVC.viewTag = tableView.tag;
        [self.navigationController pushViewController:detainVC animated:YES];
      
        [detainVC release];
    } else {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        NSString *contURL = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/content/%@?&tplId=Tpl1", ((TrainListModel *)self.dataArray[indexPath.row]).listID];
        detailVC.detailURL = contURL;
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    }
}


- (void)setTitID:(NSString *)titID {
    if (_titID != titID) {
        [_titID release];
        _titID = titID;
    }
}



#pragma mark - UITableViewDelegate

// 传唯一标识符ID
- (void)getTitleID:(NSString *)titID {
    [self getDataWithURLString:titID];
}



// 网络数据请求解析
- (void)getDataWithURLString:(NSString *)str {
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    // 创建URL对象
    NSString *urlStr = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/6944/listcontents?column_id=%@&from=%@&size=15", str, @(self.start)];
    NetWorkManager *net = [[NetWorkManager alloc] init] ;
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        [self analysisData:object];
      
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);  // 解析失败
    }];;
    [net release];
}

// 下拉 上拉刷新
- (void)analysisData:(NSDictionary *)dic {
    
    
    for (NSDictionary *tempDic in dic[@"data"][@"listData"]) {
        // 封装
        TrainListModel *trainListModel = [TrainListModel trainListModelWithDictionary:tempDic];
        //添加到array数据源
        [self.dataArray addObject:trainListModel];
    }
    // 调用刷新方法
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    // 解析完成刷新数据
    [self.tableView reloadData];
    // 隐藏加载菊花
   [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    
}

#pragma mark --- MJRefresh
- (void)addRefreshAndLoadMore {
    // 添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(handleRefresh)];
    // 添加上啦刷新
    [self.tableView addFooterWithTarget:self action:@selector(handleLoadMore)];
}

// 下拉刷新
- (void)handleRefresh {
    [self.dataArray removeAllObjects];
    // 1.参数重新设置为初始值
    self.start = 0;
    // 2.调用请求数据的方法
    [self getDataWithURLString:self.titID];
    

}

- (void)handleLoadMore {
    // 1.请求下一页数据
    self.start += 15;
    // 2.调用请求数据的方法
    [self getDataWithURLString:self.titID];
}







// 释放
- (void)dealloc
{
    self.dataArray = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
