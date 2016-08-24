//
//  HeaderFiveBtnModel.h
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderFiveBtnModel : NSObject
@property (nonatomic, copy) NSString *thumb; // cell 图片链接
@property (nonatomic, copy) NSString *cID;  // id 标识符
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *down;  // 下载次数
@property (nonatomic, copy) NSString *dance; // 舞种
@property (nonatomic, copy) NSString *degree; // 级别
@property (nonatomic, copy) NSString *like_count; // 喜欢人数

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)hederModelWithDictionary:(NSDictionary *)dic;

@end
