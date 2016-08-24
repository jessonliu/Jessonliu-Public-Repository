//
//  DiscoverViewCell.m
//  DancingDemol
//
//  Created by lanouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "DiscoverViewCell.h"
#import "UIImageView+Cache.h"
#import "DiscoverCellModel.h"

@implementation DiscoverViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DiscoverCellModel *)model {
    if (_model != model) {
        [_model release];
        [_model retain];
    }
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    
    //处理图片
    [self.photoImageView JF_setImageWithURL:model.photo placeHolderImage:@"default_indexpic_2x.png"];
    
}

- (void)dealloc {
    [_titleLabel release];
    [_subTitleLabel release];
    [_photoImageView release];
    self.model = nil;
    [super dealloc];
}
@end
