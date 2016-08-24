//
//  HeaderFiveBtnViewCell.h
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderFiveBtnModel.h"

@interface HeaderFiveBtnViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *cellImageView; // cell 图片
@property (nonatomic, retain) UIImageView *likeImage; // 喜欢人数图片
@property (nonatomic, retain) UILabel *likeCountLabel; // 喜欢人数
@property (nonatomic, retain) UIImageView *bottomImageView; // 底部锯齿图
@property (nonatomic, retain) UILabel *titleLabel; // 标题
@property (nonatomic, retain) UIImageView *smallImage; // 小标签图片
@property (nonatomic, retain) UILabel *gradeLabel;  // 级别
@property (nonatomic, retain) UILabel *danceKindLabel;  // 舞种

- (void)configureCellWithModel:(HeaderFiveBtnModel *)model;





@end
