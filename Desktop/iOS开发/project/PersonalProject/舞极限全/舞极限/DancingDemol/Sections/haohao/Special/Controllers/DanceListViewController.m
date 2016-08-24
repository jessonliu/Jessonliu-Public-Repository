//
//  DanceListViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "DanceListViewController.h"
#import "DanceListCell.h"
#import "DanceListModel.h"
#import "MovieDetailListViewController.h"
#import "NSData+WithURLAndCache.h"

@interface DanceListViewController ()

@property (nonatomic, retain)NSMutableArray *dataSource;

@end

@implementation DanceListViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [@[] mutableCopy];
    
    [self getData];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[DanceListCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getData {
    NSString *url = @"http://interface.tiaooo.com/?&platform=android&version=2.6.3&page=1&c=school&m=album";
    
    [NSData DataWithURL:url fileName:@"danceList" getSuccess:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [dic[@"data"] enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
            DanceListModel *model = [[DanceListModel new] autorelease];
            [model setValuesForKeysWithDictionary:obj];
            [self.dataSource addObject:model];
            [self.collectionView reloadData];
        }];
        
    } getFail:nil];
    
    
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DanceListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DanceListModel *model = self.dataSource[indexPath.row];
    [cell.listImageView JF_setImageWithURL:model.thumb placeHolderImage:@"default_indexpic_2x.png"];
    cell.titleLabel.text = model.title;
    cell.hitsLabel.text = model.hits;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DanceListModel *model = self.dataSource[indexPath.row];
    HeaderDetailController *detailListVC = [[HeaderDetailController new] autorelease];
    [self.navigationController pushViewController:detailListVC animated:NO];
    
    NSString *urlStr = [NSString stringWithFormat:@"id=%@", model.listID];
    //@"http://interface.tiaooo.com/?&version=2.6.3&id=%@&c=school&m=album_row",
    //@"http://interface.tiaooo.com/?&version=2.6.3&%@&page=1&c=school&m=slist"
    detailListVC.viewTag = 205 + indexPath.row;
    detailListVC.str = urlStr;
    detailListVC.postfix = @"m=album_row";
    detailListVC.key = @"school";
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}

@end
