//
//  DiscoverCellModel.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DiscoverCellModel.h"

@implementation DiscoverCellModel
- (void)dealloc {
    self.photo = nil;
    self.title = nil;
    self.subTitle = nil;
    self.covID = nil;
    [super dealloc];
}


+ (id)modelWithDic:(NSDictionary *)dic {
    DiscoverCellModel *model = [[[DiscoverCellModel alloc] init] autorelease];
    model.photo = dic[@"thumb"];
    model.title = dic[@"name"];
    model.subTitle = dic[@"enname"];
    model.covID = dic[@"id"];
    return model;
}

@end
