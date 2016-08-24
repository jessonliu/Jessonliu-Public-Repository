//
//  PerformanceViewCell.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "PerformanceViewCell.h"
#import "PerformanceCellModel.h"
#import "UIImageView+Cache.h"

@implementation PerformanceViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setModel:(PerformanceCellModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleContent.numberOfLines = 0;
    self.learnedNumber.text = model.learnNumber;
    self.level.text = model.level;
    self.agree.text = model.likeCount;
    self.owner.text = model.type;
    self.titleContent.text = model.title;
    //处理图片
    [self.displayImage JF_setImageWithURL:model.aThumb placeHolderImage:@"default_indexpic_2x.png"];
    
}

- (void)dealloc {
    [_learnedNumber release];
    [_displayImage release];
    [_level release];
    [_agree release];
    [_owner release];
    [_model release];
    [_titleContent release];
    [super dealloc];
}

@end
