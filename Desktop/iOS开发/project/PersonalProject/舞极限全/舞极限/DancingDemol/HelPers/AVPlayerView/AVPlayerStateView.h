//
//  AVPlayerStateView.h
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerTumberView.h"



@interface AVPlayerStateView : UIView


@property (nonatomic, retain) UIButton *stateBtn;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UIButton *screenStateBtn; // 屏幕状态
@property (nonatomic, retain) UILabel *timeLable;
@property (nonatomic, retain) AVPlayerTumberView *thumbView;
@property (nonatomic, retain) UIProgressView *cushionView;

@end