//
//  PM25_DataModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PM25_DataModel : NSObject




@property (nonatomic, copy)NSNumber *aqi;//空气污染指数
@property (nonatomic, copy)NSNumber *quality;//空气污染程度
@property (nonatomic, copy)NSNumber *pm2_5;//pm2.5
@property (nonatomic, copy)NSNumber *no2;//二氧化氮
@property (nonatomic, copy)NSString *co;//一氧化碳
@property (nonatomic, copy)NSNumber *pm10;//pm10
@property (nonatomic, copy)NSNumber *so2;//二氧化硫
@property (nonatomic, copy)NSNumber *o3;//臭氧

@end
