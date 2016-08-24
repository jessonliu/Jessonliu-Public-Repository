//
//  DanceViewTableViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/11.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "DanceViewTableViewController.h"
#import "DanceViewTableCellTableViewCell.h"
#import "NetWorkManager.h"
#import "SingleTon.h"
#import "TrainDetailCellDefine.h"
#import "TrainRecommendModel.h"

@interface DanceViewTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation DanceViewTableViewController

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        self.tableView = [[[ UITableView alloc] initWithFrame:self.bounds] autorelease];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
        [self.tableView registerClass:[DanceViewTableCellTableViewCell class] forCellReuseIdentifier:@"reuse"];
        self.tableView.rowHeight = 50;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self getData:[SingleTon sendDataSingleton].URLStr];
    }
    
   
    return self;
    
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
    [cell configureWithModel:self.dataSource[indexPath.row]];
    self.cellHeight = [cell returnCellHeight];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


// 分区的页眉
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2 * kMargin)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel *commentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, 3.5 * kBaseScale, 2 * kMargin)] autorelease];
    commentLabel.text = @"评论";
    commentLabel.textColor = [UIColor grayColor];
    commentLabel.font = [UIFont systemFontOfSize:14];
    [sectionHeaderView addSubview:commentLabel];
 
    
    UILabel *countLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentLabel.frame), 0, 6 * kBaseScale, 2 * kMargin)] autorelease];
    countLabel.textColor = [UIColor redColor];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.text = [NSString stringWithFormat:@"%ld", self.dataSource.count];
    [sectionHeaderView addSubview:countLabel];
    
    
    return [sectionHeaderView autorelease];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2 * kMargin;
}

// 动态返回cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}


- (void)getURLStrFromePreviousView:(NSString *)URLStr {
    [self getData:URLStr];
}

#pragma mark --- NetRequestAndAnasisy
- (void)getData:(NSString *)urlStr {
    
    // 网址拼接
    
    
    // 可变数组开辟空间
    self.dataSource = [@[] mutableCopy];
    
    NetWorkManager *net = [[[NetWorkManager alloc] init] autorelease];
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        // 枚举遍历
        for (NSDictionary *tempDic in object[@"data"]) {
            TrainRecommendModel *model = [TrainRecommendModel trainRecommendModelWithDictionary:tempDic];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
    
 
    
}

- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}


@end
