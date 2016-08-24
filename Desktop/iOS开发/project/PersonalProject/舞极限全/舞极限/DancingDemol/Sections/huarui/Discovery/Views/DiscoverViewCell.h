//
//  DiscoverViewCell.h
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverCellModel.h"

@interface DiscoverViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *photoImageView;
@property (retain, nonatomic) DiscoverCellModel *model;
@end
