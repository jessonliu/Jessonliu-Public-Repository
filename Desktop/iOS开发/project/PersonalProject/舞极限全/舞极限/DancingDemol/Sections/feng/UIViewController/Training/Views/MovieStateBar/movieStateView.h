//
//  movieStateView.h
//  DancingDemol
//
//  Created by laouhn on 15/10/5.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbView.h"


@interface movieStateView : UIView 

@property (nonatomic, retain) UIButton *stateBtn;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UIButton *screenStateBtn; // 屏幕状态
@property (nonatomic, retain) UILabel *timeLable;
@property (nonatomic, retain) ThumbView *thumbView;
@property (nonatomic, retain) UIProgressView *cushionView;
@property (nonatomic, retain) UISlider *slider; // 滑块

@end
