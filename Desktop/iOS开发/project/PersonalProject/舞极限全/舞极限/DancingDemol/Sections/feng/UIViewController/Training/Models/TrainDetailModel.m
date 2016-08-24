//
//  TrainDetailModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainDetailModel.h"

@implementation TrainDetailModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}



- (void)dealloc
{
    self.host = nil;
    self.filepath = nil;
//    self.moviePath = nil;
    [super dealloc];
}

@end
