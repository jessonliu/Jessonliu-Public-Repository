//
//  UIImageView+AsyncImage.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/25.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UIImageView+AsyncImage.h"

@implementation UIImageView (AsyncImage)

- (void)lo_setImageWithURL:(NSString *)imageURL {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        UIImage *image = [UIImage imageWithData:data];
        self.image = image;
    }];
    
}

@end
