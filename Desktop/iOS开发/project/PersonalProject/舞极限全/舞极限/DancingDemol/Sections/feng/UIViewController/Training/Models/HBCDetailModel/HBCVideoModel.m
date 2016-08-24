//
//  HBCVideoModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "HBCVideoModel.h"

@implementation HBCVideoModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.vID = value;
    }
    
}


 
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)videoModelWithDictionary:(NSDictionary *)dic {
    return [[[HBCVideoModel alloc] initWithDictionary:dic] autorelease];
}


- (void)dealloc {
    self.vID = nil;
    self.title = nil;
    self.path = nil;
    [super dealloc];
}

@end
