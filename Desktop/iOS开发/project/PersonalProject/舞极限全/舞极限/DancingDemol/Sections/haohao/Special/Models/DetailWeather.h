//
//  DetailWeather.h
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZSModel.h"
#import "PM25_DataModel.h"

@interface DetailWeather : NSObject

@property (nonatomic, retain)NSString *name;//当前城市名
@property (nonatomic, retain)NSString *temp;//温度区间
@property (nonatomic, retain)NSString *iconImageView;//天气图片
@property (nonatomic, retain)NSMutableArray *ZSArray;//穿衣, 洗车, 晾晒, 运动, 雨伞, 紫外线 6项指数
@property (nonatomic, retain)PM25_DataModel *pm25Data;//空气质量指数
@property (nonatomic, copy)NSString *report;//天气预报
@property (nonatomic, copy)NSString *zwx;//紫外线强度
@property (nonatomic, copy)NSString *fx;//风向
@property (nonatomic, copy)NSString *sd;//湿度
@end
