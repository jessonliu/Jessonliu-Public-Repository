//
//  DiscoverCellModel.h
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverCellModel : NSObject

@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *covID;

+ (id)modelWithDic:(NSDictionary *)dic;

@end
