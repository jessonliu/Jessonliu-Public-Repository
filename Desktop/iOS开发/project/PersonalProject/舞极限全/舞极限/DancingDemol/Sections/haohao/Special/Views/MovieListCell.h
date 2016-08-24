//
//  MovieListCell.h
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherVideoModel.h"

@interface MovieListCell : UITableViewCell


@property (nonatomic, retain)UIView *colorLine1;//彩色分割线
@property (nonatomic, retain)UIView *colorLine2;
@property (nonatomic, retain)UILabel *nameLabel;//视频名
@property (nonatomic, retain)UIImageView *playImageView;//播放图标(不用管)
@property (nonatomic, retain)OtherVideoModel *videoModel;//对应的视频的信息


@end
