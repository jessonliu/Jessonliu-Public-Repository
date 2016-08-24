//
//  DancingCellModel.h
//  DancingDemol
//
//  Created by lanouhn on 15/10/10.
//  Copyright (c) 2015年 JHH. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DancingCellModel : NSObject

@property (nonatomic, copy) NSString *memberAvatars;//头像
@property (nonatomic, copy) NSString *memberName;//昵称
@property (nonatomic, copy) NSString *location;//位置
@property (nonatomic, copy) NSString *createTime;//发布时间
@property (nonatomic, copy) NSString *contents;//内容页
@property (nonatomic, copy) NSString *sectionName;//签到
@property (nonatomic, retain) NSNumber *jointNum;//点赞
@property (nonatomic, copy) NSString *commentNum;//评论
@property (nonatomic, retain) NSNumber *shareNum;//分享
@property (nonatomic, retain) NSArray *contentImage;//正文图片
@property (nonatomic, retain) NSString *width;
@property (nonatomic, retain) NSString *height;
- (id)initWithDic:(NSDictionary *)dic;




@end

