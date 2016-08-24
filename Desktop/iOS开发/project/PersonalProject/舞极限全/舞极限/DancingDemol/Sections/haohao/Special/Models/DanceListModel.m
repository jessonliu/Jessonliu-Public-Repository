//
//  DanceListModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "DanceListModel.h"

@implementation DanceListModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.listID = value;
    }
}




- (void)dealloc
{
    self.listID = nil;
    self.title = nil;
    self.hits = nil;
    self.thumb = nil;
    self.content = nil;
    [super dealloc];
}




@end
