//
//  ImageAndLabeCell.h
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+Cache.h"

@class ListModel;
@interface ImageAndLabeCell : UICollectionViewCell


@property (nonatomic, retain)ListModel *model;
@property (nonatomic, retain)UIImageView *list_imageView;
@property (nonatomic, retain)UILabel *list_label;

@end
