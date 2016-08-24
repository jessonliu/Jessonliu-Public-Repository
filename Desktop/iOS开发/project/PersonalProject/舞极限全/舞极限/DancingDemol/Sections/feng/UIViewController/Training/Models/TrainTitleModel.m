//
//  TrainTitleModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainTitleModel.h"

@implementation TrainTitleModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.titleID = value;
    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)trainTltleModelWithDictionary:(NSDictionary *)dic {
    return [[[TrainTitleModel alloc] initWithDictionary:dic] autorelease];
}

- (void)dealloc
{
    self.titleID = nil;
    self.name = nil;
    [super dealloc];
}

@end
