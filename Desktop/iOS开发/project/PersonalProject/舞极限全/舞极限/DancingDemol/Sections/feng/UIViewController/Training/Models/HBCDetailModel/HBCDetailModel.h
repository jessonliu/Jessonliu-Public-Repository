//
//  HBCDetailModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCDetailModel : NSObject
@property (nonatomic, copy) NSString *mID; // ID标示符
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *content; // 内容介绍
@property (nonatomic, copy) NSString *nicheng; //舞者名字
@property (nonatomic, copy) NSString *face; // 舞者头像
@property (nonatomic, copy) NSString *like_count; // 喜欢人数
@property (nonatomic, copy) NSString *comment_count; // 评论

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)detailModelWithDictionary:(NSDictionary *)dic;
















@end
