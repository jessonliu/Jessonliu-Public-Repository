//
//  AVPlayerStateView.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "AVPlayerStateView.h"
#import "TrainDetailCellDefine.h"


@implementation AVPlayerStateView


// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //        self.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.stateBtn];
        [self addSubview:self.cushionView];
        [self addSubview:self.progressView];
        [self addSubview:self.screenStateBtn];
        [self addSubview:self.timeLable];
        [self addSubview:self.thumbView];
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

- (AVPlayerTumberView *)thumbView {
    if (!_thumbView) {
        self.thumbView = [[[AVPlayerTumberView alloc] initWithFrame:CGRectMake((kBaseScale * 3 + 2 * kMargin), 4 + kMargin / 2, 14, 14)] autorelease];
        self.thumbView.backgroundColor = [UIColor orangeColor];
        self.thumbView.layer.cornerRadius = 7;
        self.thumbView.layer.masksToBounds = YES;
        self.thumbView.userInteractionEnabled = YES;
    }
    return [[_thumbView retain] autorelease];
}


- (UIButton *)screenStateBtn {
    if (!_screenStateBtn) {
        self.screenStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.screenStateBtn.frame = CGRectMake(CGRectGetMaxX(self.progressView.frame) + kMargin, kMargin / 2, 4 * kBaseScale, 4 * kBaseScale - kMargin);
        self.screenStateBtn.layer.cornerRadius = 8;
        self.screenStateBtn.layer.masksToBounds = YES;
        self.screenStateBtn.backgroundColor = [UIColor yellowColor];
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

