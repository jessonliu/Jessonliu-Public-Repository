//
//  HH_CommentTableVC.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HH_TableHeaderView2.h"

@interface HH_CommentTableVC : UITableViewController





@property (nonatomic, retain)NSMutableArray *iconDataSource; //上面有9个头像, 提供一个数组 (9个头像的url连接)
@property (nonatomic, retain)NSString *likeCountNumber;//不固定内容 红色 显示喜欢人数
@property (nonatomic, retain)NSMutableArray *userIcon;//存放用户头像的数组
@property (nonatomic, retain)NSMutableArray *userName;//存放用户昵称的数组  string
@property (nonatomic, retain)NSMutableArray *userComment;//存放用户评论的内容  string


@property (nonatomic, strong)HH_TableHeaderView2 *headerView;


@property (nonatomic, strong) NSMutableArray *dataSource; // 存取内容数据


@end
