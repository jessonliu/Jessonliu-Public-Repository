//
//  NetworkManager.h
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkManager;
@protocol NetworkManagerDelegate <NSObject>

@optional
- (void)getDataSuccess:(NetworkManager *)network object:(id)obj;
- (void)getDataFail:(NetworkManager *)network error:(NSError *)error;

@end

typedef void (^successBlock)(NetworkManager *net, id object);

typedef void (^failBlock)(NetworkManager *net, NSError *error);

@interface NetworkManager : NSObject
//创建属性遵守协议
@property (nonatomic, assign) id<NetworkManagerDelegate>delegate;
- (void)getDataWithURL:(NSString *)urlStr parameter:(NSString *)parameter;

- (void)getDataWithURL:(NSString *)urlStr success:(successBlock)success fail:(failBlock)fail;

@end
