//
//  OtherVideoModel.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "OtherVideoModel.h"

@implementation OtherVideoModel


-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    
}



- (void)dealloc
{
    self.title = nil;
    self.path = nil;
    [super dealloc];
}

@end
