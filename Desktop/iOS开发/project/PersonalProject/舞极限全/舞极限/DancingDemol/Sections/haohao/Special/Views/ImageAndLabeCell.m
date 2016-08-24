//
//  ImageAndLabeCell.m
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "ImageAndLabeCell.h"
#import "ListModel.h"
#import "UIImageView+Cache.h"

@implementation ImageAndLabeCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)list_imageView {
    if (!_list_imageView) {
        self.list_imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, [self.model.imageWidth doubleValue]/2, [self.model.imageHeight doubleValue]/2)] autorelease];
    }
    return [[_list_imageView retain] autorelease];
}



- (UILabel *)list_label {
    if (!_list_label) {
        
        self.list_label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30) / 2, 0)] autorelease];
        //设置自动行数与字符换行
        [_list_label setNumberOfLines:2];
        _list_label.font = [UIFont systemFontOfSize:13];
        _list_label.textAlignment = NSTextAlignmentLeft;
        _list_label.lineBreakMode = 4;
        [_list_label sizeToFit];
    }
    return [[_list_label retain] autorelease];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.list_imageView];
        [self.contentView addSubview:self.list_label];
    }
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.list_imageView.frame = CGRectMake(5, 5, frame.size.width-10, frame.size.height * 0.75 - 10);
    self.list_label.frame = CGRectMake(5, CGRectGetMaxY(self.list_imageView.frame), frame.size.width-10, frame.size.height * 0.25);
}






- (void)dealloc
{
    self.model = nil;
    self.list_imageView = nil;
    self.list_label = nil;
    [super dealloc];
}

@end