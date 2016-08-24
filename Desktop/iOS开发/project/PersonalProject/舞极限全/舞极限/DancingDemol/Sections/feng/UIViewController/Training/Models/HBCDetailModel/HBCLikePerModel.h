//
//  HBCLikePerModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCLikePerModel : NSObject

@property (nonatomic, copy) NSString *face; // 喜欢者的头像

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)likePerModelWithDictionary:(NSDictionary *)dic;


@end
