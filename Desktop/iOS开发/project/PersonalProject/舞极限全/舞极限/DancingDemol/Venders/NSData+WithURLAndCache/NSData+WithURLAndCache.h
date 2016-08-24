//
//  NSData+WithURLAndCache.h
//  DancingDemol
//
//  Created by laouhn on 15/10/15.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^getDataSuccess)(NSData *data);
typedef void(^getDataFail)(NSError *error);

@interface NSData (WithURLAndCache)

//URLStr 获取数据的url连接
//name 缓存中存放data数据的文件名  不用加.data
//success  成功获取到data后, 要做的内容
//fail  失败后要做的

+ (void)DataWithURL:(NSString *)URLStr fileName:(NSString *)name getSuccess:(getDataSuccess)success getFail:(getDataFail)fail;


@end
