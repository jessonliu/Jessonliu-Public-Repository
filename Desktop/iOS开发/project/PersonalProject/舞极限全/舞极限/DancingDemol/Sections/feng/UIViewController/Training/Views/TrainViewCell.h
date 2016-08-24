//
//  TrainViewCell.h
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainListModel.h"

@interface TrainViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *BGImageView;   //背景图片
@property (nonatomic, retain) UIImageView *cellImageView; // 图片
@property (nonatomic, retain) UILabel *pesonCount;  // 学习人数
@property (nonatomic, retain) UILabel *titleLable;  // 标题
//@property (nonatomic, retain)

// 控件赋值
- (void)configureCellWithModel:(TrainListModel *)model;


@end
