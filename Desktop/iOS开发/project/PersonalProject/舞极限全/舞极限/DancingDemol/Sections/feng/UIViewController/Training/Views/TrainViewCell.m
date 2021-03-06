//
//  TrainViewCell.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainViewCell.h"
#import "TrainDetailCellDefine.h"
#import "UIImageView+Cache.h"

@implementation TrainViewCell

// 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 添加子空间
        self.backgroundColor = [UIColor colorWithRed:228 / 256.0 green:228 / 256.0 blue:228 / 256.0 alpha:1];
        [self addSubview:self.BGImageView];
        [self addSubview:self.cellImageView];
        [self addSubview:self.titleLable];
        
        
    }
    return self;
}


// 控件赋值
- (void)configureCellWithModel:(TrainListModel *)model {
    [self.cellImageView JF_setImageWithURL:model.imageName placeHolderImage:@"default_indexpic_2x.png"];
    self.pesonCount.text = model.clickNum;
    self.titleLable.text = model.title;
    
}



// lazy loading

// 背景图
- (UIImageView *)BGImageView {
    if (!_BGImageView) {
        
        CGRect frame = CGRectMake(kMargin, kMargin / 2, kWidth_BGImageView, kHeight_cell - kMargin);
        self.BGImageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        self.BGImageView.backgroundColor = [UIColor whiteColor];
            }
    return [[_BGImageView retain] autorelease];
}

// cell 图片
- (UIImageView *)cellImageView {
    if (!_cellImageView) {
        CGRect frame = CGRectMake(2 * kMargin, kMargin * 3 / 2, [UIScreen mainScreen].bounds.size.width - 4 * kMargin, (CGRectGetHeight(self.BGImageView.frame) - 10) * 3 / 4);
        
        self.cellImageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        self.cellImageView.image = [UIImage imageNamed:@"FnUmjIbfXpOn1nvn4gWm4R4UZVLS.jpeg"];
    }
    return [[_cellImageView retain] autorelease];
}

// 学习人数
- (UILabel *)pesonCount {
    if (!_pesonCount) {
        
        CGRect frame = CGRectMake(kMarginLeft_PesonCount, kMarginTop_PesonCount / 3, kWidth_PesonCount, kHeight_PesonCount);
        
        self.pesonCount = [[[UILabel alloc] initWithFrame:frame] autorelease];
        
        // 颜色设置
        self.pesonCount.backgroundColor = [UIColor colorWithRed:207 / 256.0 green:213 / 256.0 blue:205 / 256.0 alpha:1];
        self.pesonCount.font = [UIFont systemFontOfSize:11.0];
        self.pesonCount.textColor = [UIColor whiteColor];
        self.pesonCount.textAlignment = NSTextAlignmentCenter;
        self.pesonCount.layer.cornerRadius = 8;
        self.pesonCount.layer.masksToBounds = YES;
    }
    return [[_pesonCount retain] autorelease];
}

// 标题
- (UILabel *)titleLable {
    if (!_titleLable) {
        
        CGRect frame =CGRectMake(CGRectGetMinX(self.cellImageView.frame) + kMargin, CGRectGetMaxY(self.cellImageView.frame), CGRectGetWidth(self.cellImageView.frame) - 2 * kMargin, kHeight_cell - 2 * kMargin - CGRectGetHeight(self.cellImageView.frame));
        
        self.titleLable = [[[UILabel alloc] initWithFrame:frame] autorelease];
        self.titleLable.font = [UIFont systemFontOfSize:16];
        self.titleLable.numberOfLines = 0;
        
        
    }
    return [[_titleLable retain] autorelease];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    self.BGImageView = nil;
    self.pesonCount = nil;
    self.cellImageView = nil;
    self.titleLable = nil;
    [super dealloc];
}

@end
