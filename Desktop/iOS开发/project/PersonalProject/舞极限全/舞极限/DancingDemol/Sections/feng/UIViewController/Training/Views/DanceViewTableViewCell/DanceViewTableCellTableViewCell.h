//
//  DanceViewTableCellTableViewCell.h
//  DancingDemol
//
//  Created by laouhn on 15/10/11.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainRecommendModel.h"
#import "TrainListDetailComment.h"

@interface DanceViewTableCellTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *iconImageView;  // 评论者头像
@property (nonatomic, retain) UILabel *nameLabel;  // 评论者名称
@property (nonatomic, retain) UILabel *contentLabel;  // 评论内容
@property (nonatomic, retain) UILabel *timeLabel;  // 评论时间
@property (nonatomic, retain) UIView *downBar;  // 下边分割条

- (void)configureWithModel:(TrainRecommendModel *)model;
- (void)configureListModel:(TrainListDetailComment *)model;
- (CGFloat)returnCellHeight;

@end
