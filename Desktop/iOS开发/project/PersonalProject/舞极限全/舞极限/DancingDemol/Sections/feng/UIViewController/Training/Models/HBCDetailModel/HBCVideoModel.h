//
//  HBCVideoModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCVideoModel : NSObject
@property (nonatomic, copy) NSString *vID; // 唯一标示符
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *path;  // 视频路径


- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)videoModelWithDictionary:(NSDictionary *)dic;

@end
