//
//  HBCComment.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "HBCComment.h"

@implementation HBCComment

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dic {
    return [[[HBCComment alloc] initWithDictionary:dic] autorelease];
}

- (void)dealloc {
    self.inserttime = nil;
    self.content = nil;
    self.face = nil;
    self.nicheng = nil;
    self.pnicheng = nil;
    [super dealloc];
}


@end
