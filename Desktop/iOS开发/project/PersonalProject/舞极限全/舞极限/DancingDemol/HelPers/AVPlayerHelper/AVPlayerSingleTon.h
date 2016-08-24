//
//  AVPlayerSingleTon.h
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface AVPlayerSingleTon : NSObject



+ (AVPlayerSingleTon *)sendDataSingleton;

@property (nonatomic, retain) AVPlayer *temPlayer;
@property (nonatomic, assign) CGFloat videoSecond; // 视频的总时长
@property (nonatomic, assign) CGFloat currentTime;  // 视频当前时长
@property (nonatomic, assign) BOOL playState; // 视频播放暂停的状态

@end
