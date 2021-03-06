//
//  DiscoverViewController.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverViewCell.h"
#import "NetWorkManager.h"
#import "DiscoverCellModel.h"
#import "DiscoveryDetailViewController.h"

@interface DiscoverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation DiscoverViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return [[_dataSource retain] autorelease];
}

- (void)dealloc {
    self.dataSource = nil;
    [super dealloc];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self layoutTableView];
    
    self.dataSource =[@[] mutableCopy];
    NetWorkManager *net = [[NetWorkManager alloc] init];
    [net getDataWithURLString:@"http://interface.tiaooo.com/?&m=type_list&c=elegant" success:^(NetWorkManager *net, id object) {
        for (NSDictionary *dic in object[@"data"]) {
            DiscoverCellModel *model = [DiscoverCellModel modelWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
    [net release];
    
}
- (void)layoutTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 114);
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"reuseIdentifier"];
    //设置高度
    //    self.tableView.rowHeight = 120;
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.tableView];
    
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
    DiscoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    [cell setModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 12 * [UIScreen mainScreen].bounds.size.width / 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryDetailViewController *recommentVC = [[DiscoveryDetailViewController alloc] init];
    NSString *URLStr = [NSString stringWithFormat:@"%@", ((DiscoverCellModel *)self.dataSource[indexPath.row]).covID];
    [recommentVC getBeforViewURLStr:URLStr];
    recommentVC.tableViewTagID = 100;
    [self.navigationController pushViewController:recommentVC animated:YES];
    [recommentVC release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
