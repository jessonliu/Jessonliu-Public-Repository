//
//  HH_TableHeaderView2.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroValue.h"
#import "UIImageView+Cache.h"

@interface HH_TableHeaderView2 : UIView


//上面有9个头像, 提供一个数组 (9个头像的url连接)
@property (nonatomic, retain)NSMutableArray *iconDataSource;
@property (nonatomic, retain)UIImageView *iconImagesView;//照片墙
//固定内容 "人喜欢"黑色字
@property (nonatomic, retain)UILabel *perLikeLabel;
//不固定内容 红色 显示喜欢人数
@property (nonatomic, retain)UILabel *likeCountLabel;

@end
