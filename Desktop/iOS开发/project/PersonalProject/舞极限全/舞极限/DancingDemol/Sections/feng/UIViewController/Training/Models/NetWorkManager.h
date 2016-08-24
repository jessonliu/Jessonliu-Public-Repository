//
//  NetWorkManager.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NetWorkManager;

typedef void (^SuccessBlock)(NetWorkManager *net, id object); // 定义成功的Block函数
typedef void (^FialBlock)(NetWorkManager *net, NSError *error); // 定义失败的Block函数


@interface NetWorkManager : NSObject

- (void)getDataWithURLString:(NSString *)urlStr success:(SuccessBlock)success fialBlock:(FialBlock)fial;














@end
