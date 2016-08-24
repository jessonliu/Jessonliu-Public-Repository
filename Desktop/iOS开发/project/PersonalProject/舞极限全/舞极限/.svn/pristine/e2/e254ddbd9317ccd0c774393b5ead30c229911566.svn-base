//
//  PerformanceCellModel.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "PerformanceCellModel.h"

@implementation PerformanceCellModel

+ (id)modelWithDic:(NSDictionary *)dic {
    
    PerformanceCellModel *model = [[[PerformanceCellModel alloc] init] autorelease];
    model.learnNumber = dic[@"down"];
    model.aThumb = dic[@"thumb"];
    model.title = dic[@"title"];
    model.aid = dic[@"id"];
    model.level = dic[@"degree"];
    model.type = dic[@"dance"];
    model.likeCount = dic[@"like_count"];
    return model;
    
}
- (void)dealloc
{
    self.learnNumber = nil;
    self.aThumb = nil;
    self.title = nil;
    self.aid = nil;
    self.level = nil;
    self.type = nil;
    self.likeCount = nil;
    [super dealloc];
}

@end
