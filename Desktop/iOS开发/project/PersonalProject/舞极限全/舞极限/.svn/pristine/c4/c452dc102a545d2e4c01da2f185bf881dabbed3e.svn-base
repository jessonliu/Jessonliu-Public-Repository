//
//  TrainRecommendModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainRecommendModel.h"

@implementation TrainRecommendModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.recID = value;
    }
    if ([key isEqualToString:@"length"]) {
        self.lengthViedo = [NSString stringWithFormat:@"%@ 秒", value];
    }
    if ([key isEqualToString:@"like"]) {
        self.likeCount = [value stringValue];
    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)trainRecommendModelWithDictionary:(NSDictionary *)dic {
    return [[[TrainRecommendModel alloc] initWithDictionary:dic] autorelease];
}




- (void)dealloc
{
    self.inserttime = nil;
    self.thumb = nil;
    self.recID = nil;
    self.content = nil;
    self.file = nil;
    self.nicheng = nil;
    self.likeCount = nil;
    self.lengthViedo = nil;
    self.face = nil;
    [super dealloc];
}


@end
