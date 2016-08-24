//
//  HBCLikePerModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "HBCLikePerModel.h"

@implementation HBCLikePerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)likePerModelWithDictionary:(NSDictionary *)dic {
    return [[[HBCLikePerModel alloc] initWithDictionary:dic] autorelease];
}

- (void)dealloc {
    self.face = nil;
    [super dealloc];
}

@end
