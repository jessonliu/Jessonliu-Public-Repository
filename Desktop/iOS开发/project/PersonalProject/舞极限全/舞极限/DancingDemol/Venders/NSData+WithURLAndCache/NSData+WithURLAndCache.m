//
//  NSData+WithURLAndCache.m
//  DancingDemol
//
//  Created by laouhn on 15/10/15.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "NSData+WithURLAndCache.h"

@implementation NSData (WithURLAndCache)


+ (void)DataWithURL:(NSString *)URLStr fileName:(NSString *)name getSuccess:(getDataSuccess)success getFail:(getDataFail)fail {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *pathStr = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", name]];
    if (![manager fileExistsAtPath:pathStr]) {
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                [data writeToFile:pathStr atomically:YES];
                success(data);
            } else {
                fail(connectionError);
            }
        }];
    } else if ([manager fileExistsAtPath:pathStr]) {
        NSData *data = [NSData dataWithContentsOfFile:pathStr];
        success(data);
    }
}



@end
