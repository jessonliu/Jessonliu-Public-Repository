//
//  NetworkManager.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, retain) NSURLConnection *connection;

@property (nonatomic, retain) NSMutableData *data;

@end

@implementation NetworkManager
- (void)dealloc {
    self.connection = nil;
    self.data = nil;
    [super dealloc];
}


- (void)getDataWithURL:(NSString *)urlStr parameter:(NSString *)parameter {
    //创建request开始请求
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求类型
    request.HTTPMethod = @"POST";
    //设置请求体
    request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    //开始请求
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

//服务器接收响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.data = [NSMutableData data];
}

//服务器接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

//结束加载
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //解析数据
    id obj = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    //先判断delegate是否存在, 然后再判断delegate是否响应方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(getDataSuccess:object:)]) {
        //代理必须存在, 必须响应这个方法
        [self.delegate getDataSuccess:self object:obj];
    }
}

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getDataFail:error:)]) {
        [self.delegate getDataFail:self error:nil];
    }
}


- (void)getDataWithURL:(NSString *)urlStr success:(successBlock)success fail:(failBlock)fail {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(self, obj);
        } else {
            fail(self, connectionError);
        }
    }];
}

@end
