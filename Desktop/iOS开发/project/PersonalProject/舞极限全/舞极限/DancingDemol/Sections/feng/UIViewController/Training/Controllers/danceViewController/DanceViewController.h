//
//  DanceViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/10/5.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainRecommendModel.h"

@interface DanceViewController : UIViewController

@property (nonatomic, retain) UIImageView *iconImageView;   //头像图片
@property (nonatomic, retain) UIImageView *cellImageView; // 图片
@property (nonatomic, retain) UILabel *lengthLabel;  // 视频时长
@property (nonatomic, retain) UILabel *titleLable;  // 下标题
@property (nonatomic, retain) UILabel *likeCountIV; //  喜欢人数
@property (nonatomic, retain) UIImageView *BGImageView; // 背景
@property (nonatomic, retain) UILabel *topLabel; // 上标题
@property (nonatomic, retain) UILabel *timeLabel; // 上传时间

- (void)configureCellWithModel:(TrainRecommendModel *)model;

@end
