//
//  WeatherManager.h
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"
#import "DetailWeather.h"

@class WeatherManager;

typedef void (^getSuccessBlock)(WeatherManager *manager, NSArray *arr);
typedef void (^getFailBlock)(WeatherManager *manager, NSError *error);

@interface WeatherManager : NSObject

@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, retain)WeatherModel *model;

+ (void)getWeatherModelSuccess:(getSuccessBlock)sucess fail:(getFailBlock)fail;

@end
