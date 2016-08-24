//
//  HeaderDetailController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "HeaderDetailController.h"
#import "HeaderFiveBtnViewCell.h"
#import "TrainDetailCellDefine.h"
#import "NetWorkManager.h"
#import "HeaderFiveBtnModel.h"
#import "TrainDetailViewController.h"
#import "TrainDetailViewController.h"
#import "DanceViewTableViewController.h"
#import "SingleTon.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"



@interface HeaderDetailController ()
@property (nonatomic, retain) NSMutableArray *dataSource; // 数据源
@property (nonatomic, assign) NSInteger start;

@end

@implementation HeaderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.start = 1;
    self.dataSource = [@[] mutableCopy];
    
    // 注册cell
    [self layoutCell];
    
    [self getData];
}

// 注册cell
- (void)layoutCell {
    [self.tableView registerClass:[HeaderFiveBtnViewCell class] forCellReuseIdentifier:@"reuse"];
    self.tableView.rowHeight = 24.7 * kBaseScale;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      [self addRefreshAndLoadMore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.tableView.backgroundColor = [UIColor cyanColor];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeaderFiveBtnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    [cell configureCellWithModel:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// cell 的点击时间
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainDetailViewController *trainDetailVC = [[TrainDetailViewController alloc] init];
    trainDetailVC.viewTag = self.viewTag;

    trainDetailVC.HeaderBtnCellImageViewName = ((HeaderFiveBtnModel *)self.dataSource[indexPath.row]).thumb;
    trainDetailVC.detailID = ((HeaderFiveBtnModel *)self.dataSource[indexPath.row]).cID;

    [self.navigationController pushViewController:trainDetailVC animated:NO];
    
    [trainDetailVC release];
}



//  网络数据请求解析
- (void)getData {
    // 数据源开辟空间
    
    NSString *urlStr = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&%@&page=%ld&c=school&%@", self.str,self.start, self.postfix];
    NetWorkManager *net = [[[NetWorkManager alloc] init] autorelease];
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
       
        [self analysisData:object];
        
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
}


// 下拉 上拉刷新
- (void)analysisData:(id)object {
    
    
    if (!self.key) {
        for (NSDictionary *dic in object[@"data"]) {
            HeaderFiveBtnModel *model = [HeaderFiveBtnModel hederModelWithDictionary:dic];
            [self.dataSource addObject:model];
        }
    } else {
        for (NSDictionary *dic in object[@"data"][self.key]) {
            HeaderFiveBtnModel *model = [HeaderFiveBtnModel hederModelWithDictionary:dic];
            [self.dataSource addObject:model];
        }
    }
    
    // 完成解析 刷新数据
    [self.tableView reloadData];    // 调用刷新方法
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
    [self.dataSource removeAllObjects];
    // 1.参数重新设置为初始值
    self.start = 1;
    // 2.调用请求数据的方法
    [self getData];
    
}

- (void)handleLoadMore {
    // 1.请求下一页数据
    self.start += 1;
    // 2.调用请求数据的方法
    [self getData];
}







- (void)dealloc
{
    self.postfix = nil;
    self.key = nil;
    self.dataSource = nil;
    self.str = nil;
    [super dealloc];
}




@end
