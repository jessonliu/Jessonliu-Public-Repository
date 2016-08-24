//
//  HBCComment.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCComment : NSObject
@property (nonatomic, copy) NSString *inserttime; // 上传时间按
@property (nonatomic, copy) NSString *content;  // 评论内容
@property (nonatomic, copy) NSString *face;  // 头像
@property (nonatomic, copy) NSString *nicheng; // 昵称
@property (nonatomic, copy) NSString *pnicheng; // 被回复的人的昵称

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dic;


@end
