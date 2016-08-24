//
//  AVPlayerSingleTon.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "AVPlayerSingleTon.h"

@implementation AVPlayerSingleTon

+ (AVPlayerSingleTon *)sendDataSingleton {
    static AVPlayerSingleTon *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[AVPlayerSingleTon alloc] init];
    });
    return single;
}



@end
