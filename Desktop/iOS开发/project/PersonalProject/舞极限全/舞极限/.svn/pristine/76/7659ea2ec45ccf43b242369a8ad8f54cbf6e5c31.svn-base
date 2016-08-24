//
//  WeatherModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "WeatherModel.h"

@interface WeatherModel()

@property (nonatomic, retain)CLLocationManager *locationManager;

@end


@implementation WeatherModel








- (void)getPlacemarkSucess:(successBlock )sucess faild:(faildBlock )faild {
    self = [super init];
    if (self) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        //请求授权
        if ([CLLocationManager authorizationStatus] == 0) {
            [self.locationManager requestAlwaysAuthorization];
        }
        //设置定位精度(最优)
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置代理
        self.locationManager.delegate = self;
        //开始定位
        [self.locationManager startUpdatingLocation];
        
        self.sucess = sucess;
        self.faild = faild;
    }
    
    
}
//定位失败触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
//定位成功触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //停止定位, 否则会每秒定位一次
    [self.locationManager stopUpdatingLocation];
    
    
    //经纬度
//    CLLocationCoordinate2D oldCoordinate = manager.location.coordinate;
//    NSLog(@"旧的经度%lf, 旧的维度%lf", oldCoordinate.longitude, oldCoordinate.latitude);
    
    //反地理位置编码(将经纬度变成地址)
    CLGeocoder *geocoder = [[[CLGeocoder alloc] init] autorelease];
    [geocoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark *obj, NSUInteger idx, BOOL *stop) {
            if (obj) {
                self.sucess(self, obj);
            } else {
                self.faild(self, error);
            }
        }];
    }];
//    NSLog(@"---%@", self.placemark.addressDictionary);
}


- (void)dealloc
{
    self.locationManager = nil;
    [super dealloc];
}

@end
