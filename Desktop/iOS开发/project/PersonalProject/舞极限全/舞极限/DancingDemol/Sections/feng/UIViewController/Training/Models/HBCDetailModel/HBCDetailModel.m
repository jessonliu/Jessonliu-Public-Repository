//
//  HBCDetailModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "HBCDetailModel.h"

@implementation HBCDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.mID = value;
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"like_count"]) {
        self.like_count = [value stringValue];
    } else {
        [super setValue:value forKey:key];
    }
}






- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)detailModelWithDictionary:(NSDictionary *)dic {
    return [[[HBCDetailModel alloc] initWithDictionary:dic] autorelease];
}



- (void)dealloc {
    self.mID = nil;
    self.title = nil;
    self.content = nil;
    self.nicheng = nil;
    self.face = nil;
    self.like_count = nil;
    self.comment_count = nil;
    [super dealloc];
}

@end
