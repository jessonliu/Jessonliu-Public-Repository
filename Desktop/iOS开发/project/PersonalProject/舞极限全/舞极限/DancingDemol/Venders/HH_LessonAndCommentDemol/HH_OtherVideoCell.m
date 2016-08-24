//
//  HH_OtherVideoCell.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_OtherVideoCell.h"

@implementation HH_OtherVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



/*
 //有一个视频名字, 一个视频连接  一个播放的按钮图片
 @property (nonatomic, strong)UILabel *videoNameLabel;
 @property (nonatomic, strong)NSString *videoPath;
 @property (nonatomic, strong)UIImageView *playImageView;
 */

- (UILabel *)videoNameLabel {
    if (!_videoNameLabel) {
        self.videoNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15*kOneWidth5s, 3*kOneHeight5s, 200*kOneWidth5s, 25*kOneHeight5s)] autorelease];
        _videoNameLabel.font = [UIFont systemFontOfSize:12];
        _videoNameLabel.textColor = [UIColor grayColor];
    }
    return _videoNameLabel;
}

- (UIImageView *)playImageView {
    if (!_playImageView) {
        self.playImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(280*kOneWidth5s, 5 *kOneHeight5s, 20*kOneWidth5s, 20*kOneHeight5s)] autorelease];
        _playImageView.image = [UIImage imageNamed:@"lessonDetailPlay"];
    }
    return _playImageView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        
        [self addSubview:self.videoNameLabel];
        [self addSubview:self.playImageView];
    }
    return self;
}

@end
