//
//  TrainDetailViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainRecommendModel.h"
#import "TrainListModel.h"
#import <AVFoundation/AVFoundation.h>


@interface TrainDetailViewController : UIViewController

@property (nonatomic, retain) AVPlayerItem *playerItem;
@property (nonatomic, retain) AVPlayer *dancePlayer;
@property (nonatomic, retain) AVPlayerLayer *layer;
@property (nonatomic, copy) NSString *detailID;
@property (nonatomic, copy) NSString *movieStr; // 视频连接地址
@property (nonatomic, retain) UIImageView *movieImage;
@property (nonatomic, retain) TrainRecommendModel *model;
@property (nonatomic, retain) TrainListModel *listModel;
@property (nonatomic, assign) NSInteger viewTag;
@property (nonatomic, retain) NSMutableArray *dataMoviePath;
@property (nonatomic, retain) NSString *HeaderBtnCellImageViewName;
@end
