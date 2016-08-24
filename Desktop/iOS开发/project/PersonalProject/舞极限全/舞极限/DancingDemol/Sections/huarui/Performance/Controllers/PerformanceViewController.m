//
//  PerformanceViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/21.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "PerformanceViewController.h"
#import "PerformanceViewCell.h"
#import "NetWorkManager.h"
#import "PerformanceCellModel.h"
#import "TrainDetailViewController.h"
#import "MJRefresh.h"

@interface PerformanceViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;//存储数组
@property (nonatomic, retain)UITableView *tableView;

@end

@implementation PerformanceViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return [[_dataSource retain] autorelease];
}
- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    //布局tableView
    [self layoutTableView];
    
    [self getData];
    
}
- (void)getData {
    [[[NetWorkManager alloc] init] getDataWithURLString:[NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&page=%@&c=school&m=slist",@(self.page)] success:^(NetWorkManager *net, id object) {
        //解析数据
        [self parserDataWithObject:object];
        [self.tableView reloadData];
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//解析数据
- (void)parserDataWithObject:(NSDictionary *)object {
    if (self.page == 0) {
        [self.dataSource removeAllObjects];
    }
    for (NSDictionary *dic in object[@"data"]) {
        
        PerformanceCellModel *model = [PerformanceCellModel modelWithDic:dic];
        
        [self.dataSource addObject:model];
    }
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.tableView reloadData];
    
}
#pragma mark --- MJRefresh

- (void)addRefreshAndLoadMore {
    //添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(handleRefresh)];
    //添加上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(hanleLoadMore)];
}

//下拉刷新
- (void)handleRefresh {
    [self.dataSource removeAllObjects];
    //下拉刷新
    //1. 参数重新设置为初始值
    self.page = 1;
    //2. 调用请求数据的方法
    [self getData];
}

//上拉加载
- (void)hanleLoadMore {
    //1. 请求下一页数据的参数
    self.page += 1;
    //2. 调用请求数据的方法
    [self getData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)layoutTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 110);
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PerformanceViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"111"];
    
    //设置高度
    //    self.tableView.rowHeight = 150;
    
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    //添加上拉加载, 下拉刷新
    [self addRefreshAndLoadMore];

    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PerformanceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111" forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainDetailViewController *trainDetailVC = [[TrainDetailViewController alloc] init];
    trainDetailVC.viewTag = 241;
    
    trainDetailVC.HeaderBtnCellImageViewName = ((PerformanceCellModel *)self.dataSource[indexPath.row]).aThumb;
    trainDetailVC.detailID = ((PerformanceCellModel *)self.dataSource[indexPath.row]).aid;
    
    
    [self.navigationController pushViewController:trainDetailVC animated:NO];
    
    [trainDetailVC release];
}






@end
