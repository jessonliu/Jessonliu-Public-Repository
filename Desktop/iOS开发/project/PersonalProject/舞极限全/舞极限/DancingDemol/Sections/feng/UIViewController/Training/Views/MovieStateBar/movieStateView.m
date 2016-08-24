//
//  movieStateView.m
//  DancingDemol
//
//  Created by laouhn on 15/10/5.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "movieStateView.h"
#import "TrainDetailCellDefine.h"

@implementation movieStateView

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.stateBtn];
//        [self addSubview:self.cushionView];
//        [self addSubview:self.progressView];
        [self addSubview:self.screenStateBtn];
        [self addSubview:self.timeLable];
//        [self addSubview:self.thumbView];
        [self addSubview:self.slider];
    }
    return self;
}

- (UIButton *)stateBtn {
    if (!_stateBtn) {
        self.stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.stateBtn.frame = CGRectMake(kMargin, kMargin / 2, kBaseScale * 3, kBaseScale * 3);
        self.stateBtn.layer.cornerRadius = kBaseScale * 3 / 2;
        [self.stateBtn setImage:[UIImage imageNamed:@"跳吧播放详情_开始@2x"] forState:UIControlStateNormal];
    }
    return [[_stateBtn retain] autorelease];
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        self.progressView = [[[UIProgressView alloc] initWithFrame:CGRectMake(kBaseScale * 3 + 2 * kMargin, kBaseScale + kMargin / 2, 22 * kBaseScale - kMargin, 10)] autorelease];
        self.progressView.alpha = 0.7;
    }
    return [[_progressView retain] autorelease];
}

- (UIProgressView *)cushionView {
    if (!_cushionView) {
        self.cushionView = [[[UIProgressView alloc] initWithFrame:CGRectMake(kBaseScale * 3 + 2 * kMargin, kBaseScale + kMargin / 2, 22 * kBaseScale - kMargin, 10)] autorelease];
        self.cushionView.progressTintColor = [UIColor whiteColor];
    }
    return [[_cushionView retain] autorelease];
}
- (ThumbView *)thumbView {
    if (!_thumbView) {
        self.thumbView = [[[ThumbView alloc] initWithFrame:CGRectMake((kBaseScale * 3 + 2 * kMargin), 4 + kMargin / 2, 14, 14)] autorelease];
        self.thumbView.image = [UIImage imageNamed:@"4@3x"];
        self.thumbView.layer.cornerRadius = 7;
        self.thumbView.layer.masksToBounds = YES;
        self.thumbView.userInteractionEnabled = YES;
    }
    return [[_thumbView retain] autorelease];
}

- (UISlider *)slider {
    if (!_slider) {
        self.slider = [[[UISlider alloc] initWithFrame:CGRectMake(kBaseScale * 3 + 2 * kMargin, kBaseScale, 22 * kBaseScale - kMargin, 10)] autorelease];
        [self.slider setThumbImage:[UIImage imageNamed:@"player_choice_pitch_round@2x"] forState:UIControlStateNormal];
        [self.slider setThumbImage:[UIImage imageNamed:@"player_choice_pitch_round@2x"] forState:UIControlStateHighlighted];
    }
    return [[_slider retain] autorelease];
}


- (UIButton *)screenStateBtn {
    if (!_screenStateBtn) {
        self.screenStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.screenStateBtn setBackgroundImage:[UIImage imageNamed:@"adFullScreen"] forState:UIControlStateNormal];
        self.screenStateBtn.frame = CGRectMake(CGRectGetMaxX(self.progressView.frame) + 1.5 * kMargin, kMargin / 2, 2.5 * kBaseScale , 2.5 * kBaseScale);
    }
    return [[_screenStateBtn retain] autorelease];
}



- (UILabel *)timeLable {
    if (!_timeLable) {
        self.timeLable = [[[UILabel alloc] initWithFrame:CGRectMake(19 * kBaseScale - kMargin / 2, 1.5 * kBaseScale + kMargin / 2 + 3, 8 * kBaseScale + kMargin / 2, 1.5 * kBaseScale)] autorelease];
        self.timeLable.textColor = [UIColor grayColor];
        self.timeLable.font = [UIFont systemFontOfSize:12];
    }
    return [[_timeLable retain] autorelease];
}

- (void)dealloc
{
    self.cushionView = nil;
    self.thumbView = nil;
    self.stateBtn = nil;
    self.progressView = nil;
    self.screenStateBtn = nil;
    self.timeLable = nil;
    [super dealloc];
}

@end
