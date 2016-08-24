//
//  ListModel.m
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.listID = value;
    }
    if ([key isEqualToString:@"indexPic"]) {
        self.imageURL = [NSString stringWithFormat:@"%@%@%@%@", value[@"host"], value[@"dir"], value[@"filepath"], value[@"filename"]];
        self.imageWidth = value[@"width"];
        self.imageHeight = value[@"height"];
    }
}





- (void)dealloc
{
    self.publishTime = nil;
    self.listID = nil;
    self.title = nil;
    self.imageURL = nil;
    self.imageHeight = nil;
    self.imageWidth = nil;
    [super dealloc];
}




@end
