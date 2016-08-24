//
//  DanceListCell.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+Cache.h"

@interface DanceListCell : UICollectionViewCell


@property (nonatomic, retain)UIImageView *listImageView;//背景图片
@property (nonatomic, retain)UILabel *titleLabel;//标题内容
@property (nonatomic, retain)UILabel *hitsLabel;//点击量

@end
