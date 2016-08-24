//
//  SingleTon.m
//  DancingDemol
//
//  Created by laouhn on 15/10/7.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon

+ (SingleTon *)sendDataSingleton {
    static SingleTon *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[SingleTon alloc] init];
    });
    return single;
}


@end
