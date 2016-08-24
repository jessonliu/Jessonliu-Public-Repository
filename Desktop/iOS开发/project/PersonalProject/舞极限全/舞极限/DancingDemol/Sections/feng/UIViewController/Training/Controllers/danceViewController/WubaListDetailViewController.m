//
//  WubaListDetailViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/13.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "WubaListDetailViewController.h"
#import "TrainDetailCellDefine.h"
#import "DanceViewTableCellTableViewCell.h"
#import "NetWorkManager.h"
#import "TrainListDetailComment.h"

@interface WubaListDetailViewController ()

@property (nonatomic, retain) NSMutableArray *dataSource; // 数据源
@property (nonatomic, assign) CGFloat cellHeigh;

@end

@implementation WubaListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DanceViewTableCellTableViewCell class] forCellReuseIdentifier:@"reuse"];
    self.dataSource = [@[] mutableCopy];
//      [self getDataFormNetWork:self.strID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setStrID:(NSString *)strID {
    if (_strID != strID) {
        [_strID release];
        _strID = strID;
        [self.tableView reloadData];
      
    }
  }


- (void)setListModel:(TrainListModel *)listModel {
    if (_listModel != listModel) {
        [_listModel release];
        _listModel = listModel;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DanceViewTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureListModel:self.dataSource[indexPath.row]];
     self.cellHeigh = [cell returnCellHeight];
    
    return cell;
}

- (void)setCellHeigh:(CGFloat)cellHeigh {
    if (_cellHeigh != cellHeigh) {
        _cellHeigh = cellHeigh;
        [self.tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeigh;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6.5 * kBaseScale;
}

// 设置页眉
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 背景图
    UIView *bgView = [[[UIView alloc] initWithFrame:CGRectMake(0, 18 * kBaseScale + kMargin, kScreenWidth, 6.5 * kBaseScale)] autorelease];
   bgView.backgroundColor = [UIColor whiteColor];
    // 标题
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, kScreenWidth - 2 * kMargin, 5 * kBaseScale - kMargin)] autorelease];
    
    titleLabel.text = self.listModel.title;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.numberOfLines = 0;
    [bgView addSubview:titleLabel];
    // 时间
    UILabel *timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(titleLabel.frame) + kMargin / 2 , 11 * kMargin, 1.5 * kBaseScale)] autorelease];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.text = self.listModel.publishTime;
    
    timeLabel.textColor = [UIColor grayColor];
    [bgView addSubview:timeLabel];
    // 名字
    UILabel *nameLabel= [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMinY(timeLabel.frame), 10 * kMargin, CGRectGetHeight(timeLabel.frame))] autorelease];
    nameLabel.text = self.listModel.author;
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.textColor = [UIColor grayColor];
    [bgView addSubview:nameLabel];
    
    return bgView;
}


- (void)sendFromBeforeVCURLID:(NSString *)strID {
    [self getDataFormNetWork:strID];


}


// 网络数据请求解析
- (void)getDataFormNetWork:(NSString *)detailID {
    NSString *URLStr = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/content/%@/comments?&from=0&size=20", detailID];
    NetWorkManager *net = [[NetWorkManager alloc] init];
    [net getDataWithURLString:URLStr success:^(NetWorkManager *net, id object) {
        for (NSDictionary *tempDic in object[@"data"]) {
            TrainListDetailComment *model = [TrainListDetailComment listCommentWithDictionary:tempDic];
             [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
       
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        
    }];
    
    
}





- (void)dealloc
{
    self.listModel = nil;
    [super dealloc];
}



@end
