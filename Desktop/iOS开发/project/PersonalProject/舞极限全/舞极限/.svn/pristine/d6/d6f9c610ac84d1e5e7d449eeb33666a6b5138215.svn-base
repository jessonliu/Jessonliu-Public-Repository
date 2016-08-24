//
//  ListViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewWaterfallLayout.h"
@class SpecialViewController;

@interface ListViewController : UICollectionViewController<UICollectionViewDelegateWaterfallLayout>

@property (nonatomic, retain)NSString *URLID;//数据链接时, 根据不同的分栏, 拼接处不同的链接

@property (nonatomic, retain)SpecialViewController *specailVC;

- (void)listviewDidLoadWithID:(NSString *)ID type:(ListViewController *)type;


@end
