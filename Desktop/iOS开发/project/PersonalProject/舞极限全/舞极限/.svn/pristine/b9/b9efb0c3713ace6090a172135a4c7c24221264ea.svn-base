//
//  NetWorkManager.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "NetWorkManager.h"


@implementation NetWorkManager



- (void)getDataWithURLString:(NSString *)urlStr success:(SuccessBlock)success fialBlock:(FialBlock)fial {
    // GET 请求 链接
    // 如果网址中出现中文 则进行转换
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newUrlStr]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            // 如果data 存在, 解析,成功调回
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(self, obj);
        } else {
            // 如果不存在, 失败调回
            fial(self, nil);
        }
    }];
}










@end
