//
//  HH_CommentTableVC.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_CommentTableVC.h"
#import "DanceViewTableCellTableViewCell.h"

@interface HH_CommentTableVC ()

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation HH_CommentTableVC




- (void)setUserName:(NSMutableArray *)userName {
    if (_userName != userName) {
        _userName = userName;
        [self.tableView reloadData];
    }
}


- (void)setDataSource:(NSMutableArray *)dataSource {
    if (_dataSource != dataSource) {
        [_dataSource release];
        _dataSource = dataSource;
        [self.tableView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[DanceViewTableCellTableViewCell class] forCellReuseIdentifier:@"reuse"];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.headerView = [[[HH_TableHeaderView2 alloc] initWithFrame:CGRectMake(0, 0, kWidth, 60*kOneHeight5s)] autorelease];
    self.tableView.sectionHeaderHeight = 60*kOneHeight5s;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void)getData {
    self.userName = [@[@"1123", @"2", @"45", @"456", @"456765",@"1123", @"2", @"45", @"456",@"1123", @"2", @"45", @"456"] mutableCopy];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"132132");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
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
