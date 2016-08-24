//
//  HeaderFiveBtnModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "HeaderFiveBtnModel.h"

@implementation HeaderFiveBtnModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.cID = value;
    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)hederModelWithDictionary:(NSDictionary *)dic {
    return [[[HeaderFiveBtnModel alloc] initWithDictionary:dic] autorelease];
}

- (void)dealloc
{
    self.thumb = nil;
    self.cID = nil;
    self.title = nil;
    self.down = nil;
    self.dance = nil;
    self.degree = nil;
    self.like_count = nil;
    [super dealloc];
}
@end
