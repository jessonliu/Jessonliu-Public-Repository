//
//  UIImageView+Cache.m
//  6.ImageViewCache
//
//  Created by laouhn on 15/10/15.
//  Copyright © 2015年 Jesonliu. All rights reserved.
//

#import "UIImageView+Cache.h"

@implementation UIImageView (Cache)


- (void)JF_setImageWithURL:(NSString *)urlStr placeHolderImage:(NSString *)imageName {
    // 设置占位图片
    self.image = [UIImage imageNamed:imageName];
    // 创建存储所有图片的文件夹
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ImageCache"];
    // 用文件管理类, 来判断文件是否存在
    NSFileManager *manager = [NSFileManager defaultManager];
    // 判断文件夹是否存在
    if (![manager fileExistsAtPath:filePath]) {
        // 如果不存在, 就创建文件夹
     BOOL b = [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//        b ? NSLog(@"文件夹创建成功") : NSLog(@"文件夹创建失败");
    } else {
        // 文件夹存在不作处理
    }
    
    //判断文件夹中是否有这个URL对应的图片
    NSString *imageStr = [[[urlStr
            stringByReplacingOccurrencesOfString:@":" withString:@""]
            stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""];
    // 拼接处 image所存储的文件路径
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", filePath, imageStr];
    
    if ([manager fileExistsAtPath:imagePath]) {
        // 如果图片存在 直接取出文件  赋值给imageView (self)
        self.image = [UIImage imageWithContentsOfFile:imagePath];
        return;
    }
    // 如果图片不存在
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.image = [UIImage imageWithData:data];
        // 把data数据持久化 到本地
       BOOL b = [data writeToFile:imagePath atomically:YES];
//        b ? NSLog(@"图片保存成功") : NSLog(@"图片保存失败");
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
