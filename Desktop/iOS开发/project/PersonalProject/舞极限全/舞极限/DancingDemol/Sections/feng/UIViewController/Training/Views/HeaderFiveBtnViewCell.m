//
//  HeaderFiveBtnViewCell.m
//  DancingDemol
//
//  Created by laouhn on 15/9/29.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "HeaderFiveBtnViewCell.h"
#import "HeaderCellDefine.h"
#import "UIImageView+Cache.h"



@implementation HeaderFiveBtnViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         self.backgroundColor = [UIColor colorWithRed:228 / 256.0 green:228 / 256.0 blue:228 / 256.0 alpha:1];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kMargin / 2, kMargin / 2, kScreenWidth - kMargin, 24.7 * kBaseScale - kMargin)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView release];
        
        
        [self addSubview:self.cellImageView];
        [self addSubview:self.likeImage];
        [self addSubview:self.likeCountLabel];
        [self addSubview:self.bottomImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.smallImage];
        [self addSubview:self.gradeLabel];
        [self addSubview:self.danceKindLabel];
    }
    return self;
}



// cell 图片
- (UIImageView *)cellImageView {
    if (!_cellImageView) {
        self.cellImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin, kScreenWidth - 2 * kMargin, kHeight_CellImage)] autorelease];
//        self.cellImageView.backgroundColor = [UIColor cyanColor];
    }
    return [[_cellImageView retain] autorelease];
}

// 喜欢图标
- (UIImageView *)likeImage {
    if (!_likeImage) {
        self.likeImage = [[[UIImageView alloc] initWithFrame:CGRectMake(2 * kMargin, 2 * kMargin, kWidthAndHeight_LikeImage, kWidthAndHeight_LikeImage)] autorelease];
//        self.likeImage.backgroundColor = [UIColor yellowColor];
        self.likeImage.image = [UIImage imageNamed:@"Player_心_红色@2x"];
    }
    return [[_likeImage retain] autorelease];
}

// 喜欢人数
- (UILabel *)likeCountLabel {
    if (!_likeCountLabel) {
        self.likeCountLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImage.frame), 2 * kMargin, kWidth_LikeLabel, kHeight_LikeLabel)] autorelease];
        self.likeCountLabel.text = @"1234";
        self.likeCountLabel.font = [UIFont systemFontOfSize:12];
         self.likeCountLabel.textColor = [UIColor grayColor];
//        self.likeCountLabel.backgroundColor = [UIColor purpleColor];
    }
    return [[_likeCountLabel retain] autorelease];
}

// 底部锯齿图
- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        self.bottomImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(self.cellImageView.frame) - 3, kScreenWidth - 2 * kMargin, kHeight_BottomImage)] autorelease];
//        self.bottomImageView.backgroundColor = [UIColor redColor];
        self.bottomImageView.image = [UIImage imageNamed:@""];
    }
    return [[_bottomImageView retain] autorelease];
}


// 标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(2 * kMargin, CGRectGetMinY(self.bottomImageView.frame) + kMargin / 2, kScreenWidth  - 4 * kMargin, kHeight_titleLabel)] autorelease];
        self.titleLabel.text = @"刘教练带你装逼带你飞带你飞带你飞...";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
//        self.titleLabel.backgroundColor = [UIColor orangeColor];
    }
    return [[_titleLabel retain] autorelease];
}

// 小图标
- (UIImageView *)smallImage {
    if (!_smallImage) {
        self.smallImage = [[[UIImageView alloc] initWithFrame:CGRectMake(2 *kMargin, CGRectGetMaxY(self.titleLabel.frame), kWidAndHei_SmallImage, kWidAndHei_SmallImage)] autorelease];
        self.smallImage.image = [UIImage imageNamed:@"dd_menu_level@2x.png"];
//        self.smallImage.backgroundColor = [UIColor whiteColor];
    }
    return [[_smallImage retain] autorelease];
}

// 级别Label
- (UILabel *)gradeLabel {
    if (!_gradeLabel) {
        self.gradeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.smallImage.frame) + kMargin / 2, CGRectGetMaxY(self.titleLabel.frame), kWidth_Grade, kHeight_Grade)] autorelease];
//        self.gradeLabel.backgroundColor = [UIColor greenColor];
        self.gradeLabel.text = @"零基础";
        self.gradeLabel.textColor = [UIColor grayColor];
        self.gradeLabel.font = [UIFont systemFontOfSize:12];
    }
    return [[_gradeLabel retain] autorelease];
}

// 舞种
- (UILabel *)danceKindLabel {
    if (!_danceKindLabel) {
        self.danceKindLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - kMargin - kWidth_DanceKind, CGRectGetMaxY(self.titleLabel.frame), kWidth_DanceKind, kHeight_Grade)] autorelease];
        self.danceKindLabel.text = @"HIPHOP";
        self.danceKindLabel.font = [UIFont systemFontOfSize:10];
        self.danceKindLabel.textColor = [UIColor grayColor];
//        self.danceKindLabel.backgroundColor = [UIColor redColor];
    }
    return [[_danceKindLabel retain] autorelease];
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
    self.cellImageView = nil;
    self.likeCountLabel = nil;
    self.likeImage = nil;
    self.bottomImageView = nil;
    self.titleLabel = nil;
    self.smallImage = nil;
    self.gradeLabel = nil;
    self.danceKindLabel = nil;
    [super dealloc];
}

- (void)configureCellWithModel:(HeaderFiveBtnModel *)model {
    [self.cellImageView JF_setImageWithURL:model.thumb placeHolderImage:@"default_indexpic_2x.png"];
    self.likeCountLabel.text = model.like_count;
    self.titleLabel.text = model.title;
    self.gradeLabel.text = model.degree;
    self.danceKindLabel.text = model.dance;
}



@end
