//
//  WeatherModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class WeatherModel;

//@protocol WeatherDeleate <NSObject>
//
//@optional
//- (void)getPlacemarkSuccess:(WeatherModel *)model object:(id)obj;
//- (void)getPlacemarkFail:(WeatherModel *)model error:(NSError *)error;
//
//@end

typedef void (^successBlock)(WeatherModel *model, CLPlacemark* obj);
typedef void (^faildBlock)(WeatherModel *model, NSError *error);


@interface WeatherModel : NSObject<CLLocationManagerDelegate>

//@property (nonatomic, assign)id<WeatherDeleate> delegate;


@property (nonatomic, copy)successBlock sucess;
@property (nonatomic, copy)faildBlock faild;



- (void)getPlacemarkSucess:(successBlock )sucess faild:(faildBlock )faild;


@end
