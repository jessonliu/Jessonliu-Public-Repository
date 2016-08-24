//
//  HH_OtherViedeoTableVC.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_OtherViedeoTableVC.h"
#import "MBProgressHUD.h"
#import "TrainDetailViewController.h"

@interface HH_OtherViedeoTableVC ()


@end

@implementation HH_OtherViedeoTableVC




- (void)setVideoNameArr:(NSMutableArray *)videoNameArr {
    if (_videoNameArr != videoNameArr) {
        _videoNameArr = videoNameArr;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.headerView = [[[HH_TableHeaderView1 alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150*kOneHeight5s)] autorelease];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = 150*kOneHeight5s;
    self.tableView.rowHeight = 30*kOneHeight5s;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
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
    return self.videoNameArr.count+1;
//    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"muyouchongyong"] autorelease];
        cell.imageView.image = [UIImage imageNamed:@"课程详细页_课程_11@2x"];
        cell.imageView.center = CGPointMake(200, 15);
        cell.textLabel.text = @"跟我来学吧";
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.userInteractionEnabled = NO;
        return cell;
    } else  {
        static NSString *identifier = @"otherVideo";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
            HH_OtherVideoCell *cell2 = [[HH_OtherVideoCell alloc] init];
            cell2.frame = cell.frame;
            [cell addSubview:cell2];
        }

        [[cell subviews] enumerateObjectsUsingBlock:^( UIView * obj, NSUInteger idx, BOOL *  stop) {
            if ([obj isKindOfClass:[HH_OtherVideoCell class]]) {
                obj.userInteractionEnabled = NO;
                ((HH_OtherVideoCell*)obj).videoNameLabel.text = self.videoNameArr[indexPath.row - 1];
                ((HH_OtherVideoCell*)obj).detailTextLabel.text = self.pathArr[indexPath.row - 1];
            }
        }];

        return cell;
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 通知传值
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"bianchengling" object:nil];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [[NSNotificationCenter defaultCenter] postNotificationName:@"SendVideoURLStr" object:nil userInfo:@{@"key":self.pathArr[indexPath.row - 1]}];
    });
    
   
}




@end
