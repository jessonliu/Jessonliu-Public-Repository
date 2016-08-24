//
//  ListViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "ListViewController.h"
#import "ListModel.h"
#import "NetWorkManager.h"
#import "SpecialViewController.h"
#import "ImageAndLabeCell.h"
#import "DetailViewController.h"
#import "BasicNVC.h"
#import "MBProgressHUD.h"
#import "NSData+WithURLAndCache.h"
#import "MJRefresh.h"
#import "UIImageView+Cache.h"
#import "UIImageView+AsyncImage.h"

@interface ListViewController ()

@property (nonatomic, retain)NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger from;
@property (nonatomic, retain)NSString *sID;
@property (nonatomic, retain)ListViewController *type;
@property (nonatomic, retain)__block NSString *filePath;

@end

@implementation ListViewController

static NSString * const reuseIdentifier = @"Cell";


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return [[_dataSource retain] autorelease];
}



- (void)listviewDidLoadWithID:(NSString *)sID type:(ListViewController *)type{
    [super viewDidLoad];
    
    self.sID = sID;
    self.type = type;
    
    [self addFresh];
    
    [MBProgressHUD showHUDAddedTo:type.collectionView animated:YES];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    
    [self.collectionView registerClass:[ImageAndLabeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //网络连接请求
    self.URLID = sID;
    [self getDataWithURLID:sID type:type withPage:0];
    
    
    
}

#pragma mark - 数据获取
- (void)getDataWithURLID:(NSString *)sID type:(ListViewController *)type  withPage:(NSInteger)a{
    
    NSString *temp = [NSString stringWithFormat:@"%ld", self.from];
    NSString *URLstr = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/12288/listcontents?&column_id=%@&from=%@&size=15&site_id=1093", self.URLID, temp];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLstr]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (a == 1) {
            [self.dataSource removeAllObjects];
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self analysisWithDictionary:dic type:type];
    }];
}

- (void)analysisWithDictionary:(NSDictionary *)dic type:(ListViewController *)type {
    
    [dic[@"data"][@"listData"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ListModel *model = [ListModel new];
        [model setValuesForKeysWithDictionary:obj];
        [self.dataSource addObject:model];
        [model release];
    }];
    //调用刷新方法
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    
    [MBProgressHUD hideHUDForView:type.collectionView animated:YES];
    [type.collectionView reloadData];
}




#pragma mark - 数据刷新
- (void)addFresh {
    [self.collectionView addHeaderWithTarget:self action:@selector(topFresh)];
    [self.collectionView addFooterWithTarget:self action:@selector(boomLoadMore)];
}

- (void)topFresh {
    self.from = 0;
    [self getDataWithURLID:self.sID type:self.type withPage:1];
}
- (void)boomLoadMore {
    self.from += 15;
    [self getDataWithURLID:self.sID type:self.type withPage:0];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (ImageAndLabeCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageAndLabeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ListModel* model = self.dataSource[indexPath.row];
    [cell.list_imageView JF_setImageWithURL:model.imageURL placeHolderImage:nil];
    cell.list_label.text = model.title;
    // Configure the cell
    
    return cell;
}

//为cell指定高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListModel *model = self.dataSource[indexPath.row];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30) / 2, 0)] autorelease];
    label.numberOfLines = 0;
    label.text = ((ListModel *)(self.dataSource[indexPath.row])).title;
    [label sizeToFit];
    
    
    return ([model.imageHeight intValue] * (([UIScreen mainScreen].bounds.size.width - 30) / 2) / ([model.imageWidth intValue]*1.0)) + CGRectGetHeight(label.frame);
    
}
#pragma mark <UICollectionViewDelegate>
//cell选中时触发
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ListModel *model = (ListModel *)(self.dataSource[indexPath.row]);
    
    //选中的cell的详情链接
    NSString *url = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/content/%@?&tplId=Tpl1", model.listID];
    
    
    //跳转到详情页面
    DetailViewController *detailVC = [DetailViewController new];
    detailVC.detailURL = url;
    BasicNVC *nav = (BasicNVC *)self.navigationController;
    [nav pushViewController:detailVC animated:YES];
    [detailVC release];
    
    return YES;
}



- (void)dealloc
{
    self.filePath = nil;
    self.sID = nil;
    self.type = nil;
    self.specailVC = nil;
    self.URLID = nil;
    [super dealloc];
}

@end