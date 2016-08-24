//
//  TrainTitleCell.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainTitleCell.h"

@implementation TrainTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

// lazy loading
// title 背景图
-(UIImageView *)imageView {
    if (!_imageView) {
        self.imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        self.imageView.image = [UIImage imageNamed:@"tabBarBGImage"];
    }
    return [[_imageView retain] autorelease];
}

// 标题名字
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:self.bounds] autorelease];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    return [[_titleLabel retain] autorelease];
    
}

// 控件赋值
- (void)configureCellWithModel:(TrainTitleModel *)model {
    self.titleLabel.text = model.name;
}

- (void)dealloc
{
    self.imageView = nil;
    self.titleLabel = nil;
    [super dealloc];
}







@end
