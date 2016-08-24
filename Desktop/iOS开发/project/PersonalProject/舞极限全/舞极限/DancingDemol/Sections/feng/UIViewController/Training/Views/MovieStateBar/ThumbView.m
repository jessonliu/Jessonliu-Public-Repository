//
//  ThumbView.m
//  DancingDemol
//
//  Created by laouhn on 15/10/5.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "ThumbView.h"
#import "TrainDetailCellDefine.h"
#import "TrainDetailModel.h"
#import "SingleTon.h"

@implementation ThumbView



- (void)touchesBegan:(NSSet *)touches withEvent:(nullable UIEvent *)event {
    self.agoX = self.center.x;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1.获取手指对象
    UITouch *touch = [touches anyObject];
    // 2.获取手指当前位置
    CGPoint currentPoint = [touch locationInView:self]; //currentPoint 当前位置
    // 3.获取手指之前位置
    CGPoint previousPoint = [touch previousLocationInView:self]; //previousPoint 之前的位置
    // 4.计算移动的增量
    CGFloat dx = currentPoint.x - previousPoint.x;
        // 5.修改视图位置.
        if (self.center.x >= (kBaseScale * 3 + 2 * kMargin) && self.center.x <= 25 * kBaseScale + kMargin) {
            // 5.修改视图位置.
            CGPoint tempPoint = self.center;
            tempPoint.x = self.center.x + dx;
            self.center = tempPoint;
        }
        else if (self.center.x > (25 * kBaseScale + kMargin)){
            CGPoint temp = self.center;
            temp.x = 25 * kBaseScale + kMargin;
            self.center = temp;
        } else if (self.center.x < (kBaseScale * 3 + 2 * kMargin)) {
            CGPoint temp = self.center;
            temp.x = (kBaseScale * 3 + 2 * kMargin);
            self.center = temp;
        }

    
    AVPlayer *player = [SingleTon sendDataSingleton].temPlayer;
    [player pause];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(nullable UIEvent *)event{
    self.userInteractionEnabled = NO;
    if ((kBaseScale * 3 + 2 * kMargin) <= self.center.x && self.center.x <= (25 * kBaseScale + kMargin)) {
        CGPoint tempPoint = self.center;
        self.center = tempPoint;
        
    } else if (self.center.x > (25 * kBaseScale + kMargin)){
        CGPoint temp = self.center;
        temp.x = (25 * kBaseScale + kMargin);
        self.center = temp;
    } else if (self.center.x < (kBaseScale * 3 + 2 * kMargin)) {
        CGPoint temp = self.center;
        temp.x = (kBaseScale * 3 + 2 * kMargin);
        self.center = temp;
    }
    
    AVPlayer *player = [SingleTon sendDataSingleton].temPlayer;
    
    // 计算出self.center.x 的增量
    CGFloat addX = self.center.x - self.agoX;
    // 计算出对应的视频前进的时间
    CGFloat second = addX * [SingleTon sendDataSingleton].videoSecond / (22 * kBaseScale - kMargin) + [SingleTon sendDataSingleton].currentTime;
    CMTime time = CMTimeMakeWithSeconds(second, player.currentTime.timescale);
    [player seekToTime:time];
    // 移动结束后 延迟两秒播放
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 如果播放器处于播放状态 则让它播放, 否则暂停
        if ([SingleTon sendDataSingleton].playState) {
            [player play];
        }
        
    });
    
    self.userInteractionEnabled = YES;
}


@end
