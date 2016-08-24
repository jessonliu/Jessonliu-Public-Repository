//
//  DetailWeather.m
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DetailWeather.h"
#import "UIImageView+Cache.h"

@implementation DetailWeather




- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"icon"]) {
        self.iconImageView = [NSString stringWithFormat:@"%@%@%@%@", value[0][@"host"], value[0][@"dir"], value[0][@"filepath"], value[0][@"filename"]];
    }
    if ([key isEqualToString:@"zs"]) {
        self.ZSArray = [NSMutableArray arrayWithCapacity:1];
        [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ZSModel *zsmodel = [[[ZSModel alloc] init] autorelease];
            [zsmodel setValuesForKeysWithDictionary:obj];
            [self.ZSArray addObject:zsmodel];
        }];
    }
    if ([key isEqualToString:@"pm25_data"]) {
        self.pm25Data = [[[PM25_DataModel alloc] init] autorelease];
        [self.pm25Data setValuesForKeysWithDictionary:value[@"avg"]];
    }
}





- (void)dealloc
{
    self.report = nil;
    self.zwx = nil;
    self.fx = nil;
    self.sd = nil;
    self.name = nil;
    self.temp = nil;
    self.iconImageView = nil;
    self.ZSArray = nil;
    self.pm25Data = nil;
    [super dealloc];
}


@end
