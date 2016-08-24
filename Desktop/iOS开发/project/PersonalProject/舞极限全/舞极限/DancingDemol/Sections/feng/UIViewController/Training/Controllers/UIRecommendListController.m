//
//  UIRecommendListController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UIRecommendListController.h"
#import "TrainRocommendCell.h"
#import "TrainRecommendModel.h"
#import "NetWorkManager.h"
#import "TrainDetailCellDefine.h"
#import "TrainDetailViewController.h"
#import "BasicNVC.h"
#import "RecomHearController.h"
#import "danceViewController/DanceViewTableViewController.h"
#import "SingleTon.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"


@interface UIRecommendListController ()


@end

@implementation UIRecommendListController

- (void)dealloc
{
    self.titID = nil;
    self.urlStr = nil;
    self.dataArray = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.start = 1;
    
    // 可变数组开辟空间
    self.dataArray = [@[] mutableCopy];
    
    // 注册cell
    [self layoutTableView];
    
    // 创建页眉
    [self layoutHeaderView];
    // 加载页面的时候添加菊花
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
     [self addRefreshAndLoadMore];
    if (self.tableViewTagID == 100) {

    } else  {
        [self getData:self.titID];
    }
    
}

// 注册cell
- (void)layoutTableView {
    // 注册cell
    [self.tableView registerClass:[TrainRocommendCell class] forCellReuseIdentifier:@"reuse"];
    // 设置行高
    self.tableView.rowHeight = kHeight_RecCll;
    // 3.设置分割线的样式
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

// 创建页眉
- (void)layoutHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight_Header)];
    self.tableView.tableHeaderView = view;
    
    RecomHearController *recommendVC =[[[RecomHearController alloc] init] autorelease];
    recommendVC.view.frame = CGRectMake(0, 0, kScreenWidth, kHeight_Header);
    [self addChildViewController:recommendVC];
    [self.tableView.tableHeaderView addSubview:recommendVC.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataArray.count;
}

// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainRocommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithModel:self.dataArray[indexPath.item]];
    
    return cell;
}

// 选中cell 触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicNVC *NVC = (BasicNVC *)self.navigationController;
    NVC.viewNVC.hidden = YES;
    TrainDetailViewController *detailVC = [[TrainDetailViewController alloc] init];
    detailVC.model = self.dataArray[indexPath.row];
    detailVC.movieStr = ((TrainRecommendModel *)self.dataArray[indexPath.row]).file;
    
    NSString *URLStr = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&id=%@&openid=040502418AAFE2976D2D683E8DAB750F&apptoken=fca532e266489d84aec05924164ac854&m=get_comment&page=1&c=elegant", ((TrainRecommendModel *)self.dataArray[indexPath.row]).recID];
    [SingleTon sendDataSingleton].URLStr = URLStr;
    //    DanceViewTableViewController *danceTableVC = [[DanceViewTableViewController alloc] init];
    //    [danceTableVC getURLStrFromePreviousView:URLStr];
    
    
    
    [self.navigationController pushViewController:detailVC animated:NO];
    [detailVC release];
}

// 其他界面传来的网址
- (void)getBeforViewURLStr:(NSString *)str {
    self.tableViewTagID = 100;
    self.titID = str;
    [self getData:str];

}


// 网络数据请求, 解析
- (void)getData:(NSString *)strID{
    NSString *str = [[[NSString alloc] init] autorelease];
    if (self.tableViewTagID == 100) {
        str = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&tid=%@&m=video_list&page=%ld&c=elegant", strID, self.start];
    } else {
        str = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&openid=040502418AAFE2976D2D683E8DAB750F&apptoken=fca532e266489d84aec05924164ac854&m=top_list&page=%ld&c=elegant", self.start];
    }
    
    NetWorkManager *net = [[[NetWorkManager alloc] init] autorelease];
    [net getDataWithURLString:str success:^(NetWorkManager *net, id object) {
 
        [self getAnalysisData:object];
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)getAnalysisData:(NSDictionary *)object {
    for (NSDictionary *dic in object[@"data"]) {
        TrainRecommendModel *model = [TrainRecommendModel trainRecommendModelWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];    // 调用刷新方法
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
    self.start = 1;
    // 2.调用请求数据的方法
    [self getData:self.titID];
    
    
}

- (void)handleLoadMore {
    // 1.请求下一页数据
    self.start += 1;
    // 2.调用请求数据的方法
    [self getData:self.titID];
}

@end
