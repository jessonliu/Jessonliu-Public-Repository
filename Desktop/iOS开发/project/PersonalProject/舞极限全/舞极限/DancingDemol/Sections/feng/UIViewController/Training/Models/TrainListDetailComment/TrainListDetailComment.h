//
//  TrainListDetailComment.h
//  DancingDemol
//
//  Created by laouhn on 15/10/13.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainListDetailComment : NSObject

@property (nonatomic, copy) NSString *content;  // 评论内容
@property (nonatomic, copy) NSString *publishTime;  // 评论时间
@property (nonatomic, copy) NSString *nickName;  // 昵称
@property (nonatomic, copy) NSString *iconImage;    // 评论者头像
@property (nonatomic, copy) NSString *memberType;  // 评论类型


- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)listCommentWithDictionary:(NSDictionary *)dic;




@end
