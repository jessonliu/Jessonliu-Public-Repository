//
//  DancingCellModel.m
//  DancingDemol
//
//  Created by lanouhn on 15/10/10.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DancingCellModel.h"

@implementation DancingCellModel

- (id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"memberAvatar"]){
        self.memberAvatars = [NSString stringWithFormat:@"%@%@%@%@", value[@"host"], value[@"dir"], value[@"filepath"], value[@"filename"]];
    }
    if ([key isEqualToString:@"content"]){
        if ([value rangeOfString:@"<div"].length != 0) {
            NSArray * ary =  [value componentsSeparatedByString:@"<div"];
            NSString * str =[ary firstObject];
            self.contents = str;
        }else{
            self.contents = value;
        }
    }
}
//释放
- (void)dealloc {
    self.jointNum = nil;
    self.shareNum = nil;
    self.contentImage = nil;
    self.width = nil;
    self.height = nil;
    [super dealloc];
}
@end
