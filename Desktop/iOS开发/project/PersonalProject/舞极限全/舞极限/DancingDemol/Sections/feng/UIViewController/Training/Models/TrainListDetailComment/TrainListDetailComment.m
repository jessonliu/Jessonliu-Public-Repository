//
//  TrainListDetailComment.m
//  DancingDemol
//
//  Created by laouhn on 15/10/13.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "TrainListDetailComment.h"

@implementation TrainListDetailComment

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqual:@"avatar"]) {
        self.iconImage = [NSString stringWithFormat:@"%@%@%@%@", value[@"host"], value[@"dir"], value[@"filepath"], value[@"filename"]];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"memberType"]) {
        self.memberType = [value stringValue];
    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)listCommentWithDictionary:(NSDictionary *)dic {
    return [[[TrainListDetailComment alloc] initWithDictionary:dic] autorelease];
}



- (void)dealloc
{
    self.content = nil;
    self.publishTime = nil;
    self.nickName = nil;
    self.memberType = nil;
    self.iconImage = nil;
    [super dealloc];
}

@end
