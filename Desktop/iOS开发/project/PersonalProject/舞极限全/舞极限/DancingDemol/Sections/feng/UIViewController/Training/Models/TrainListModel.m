//
//  TrainListModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainListModel.h"

@implementation TrainListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"indexPic"]) {
        self.imageName = [NSString stringWithFormat:@"%@%@%@%@", value[@"host"], value[@"dir"], value[@"filepath"], value[@"filename"]];
    }

    if ([key isEqualToString:@"extendValues"]) {
        self.clickNum = [NSString stringWithFormat:@"%@秒", [value[@"clickNum"] stringValue]];
        self.author = value[@"author"];
        self.source = value[@"source"];
    }
    if ([key isEqualToString:@"id"]) {
        self.listID = value;
    }
    
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];

    }
    return self;
}
+ (instancetype)trainListModelWithDictionary:(NSDictionary *)dic {
    return [[[TrainListModel alloc] initWithDictionary:dic] autorelease];
}


- (void)dealloc
{
    self.contentType = nil;
    self.listID = nil;
    self.title = nil;
    self.imageName = nil;
    self.clickNum = nil;
    self.publishTime = nil;
    self.author = nil;
    self.source = nil;
    [super dealloc];
}

@end
