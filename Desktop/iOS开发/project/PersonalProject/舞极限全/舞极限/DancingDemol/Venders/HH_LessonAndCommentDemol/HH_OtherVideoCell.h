//
//  HH_OtherVideoCell.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroValue.h"

@interface HH_OtherVideoCell : UITableViewCell

//有一个视频名字, 一个视频连接  一个播放的按钮图片
@property (nonatomic, strong)UILabel *videoNameLabel;
@property (nonatomic, strong)NSString *videoPath;
@property (nonatomic, strong)UIImageView *playImageView;


@end
