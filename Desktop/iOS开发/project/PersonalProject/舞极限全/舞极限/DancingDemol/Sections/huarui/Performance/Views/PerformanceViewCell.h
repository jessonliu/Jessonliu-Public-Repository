//
//  PerformanceViewCell.h
//  DancingDemol
//
//  Created by lanouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceCellModel.h"

@interface PerformanceViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *learnedNumber;

@property (retain, nonatomic) IBOutlet UIImageView *displayImage;

@property (retain, nonatomic) IBOutlet UILabel *titleContent;

@property (retain, nonatomic) IBOutlet UILabel *level;

@property (retain, nonatomic) IBOutlet UILabel *owner;

@property (retain, nonatomic) IBOutlet UILabel *agree;

@property (strong, nonatomic) PerformanceCellModel *model;

@end
