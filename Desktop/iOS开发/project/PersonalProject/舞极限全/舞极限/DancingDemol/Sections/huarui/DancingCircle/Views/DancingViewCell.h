//
//  DancingViewCell.h
//  DancingDemol
//
//  Created by lanouhn on 15/10/10.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DancingCellModel;
@interface DancingViewCell : UITableViewCell

@property (nonatomic, retain) DancingCellModel *model;
@property (nonatomic, assign) CGFloat cellHeight;



//头像
@property (nonatomic, retain) UIImageView *headerI;
//昵称
@property (nonatomic, retain) UILabel *nameL;
//定位
@property (nonatomic, retain) UILabel *locationL;
//发表时间
@property (nonatomic, retain) UILabel *timeL;
//正文
@property (nonatomic, retain) UILabel *contentL;
//签到
@property (nonatomic, retain) UIButton *signInV;
//点赞
@property (nonatomic, retain) UIButton *interestV;
//评论
@property (nonatomic, retain) UIButton *commentV;
//分享
@property (nonatomic, retain) UIButton *shareV;
//正文图片
@property (nonatomic, retain) UIImageView *pictureV;

-(float)returnCellHeigt;
@end
