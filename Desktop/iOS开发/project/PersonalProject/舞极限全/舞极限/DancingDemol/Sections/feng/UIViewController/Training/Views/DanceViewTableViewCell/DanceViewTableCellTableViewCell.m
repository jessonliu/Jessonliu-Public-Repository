//
//  DanceViewTableCellTableViewCell.m
//  DancingDemol
//
//  Created by laouhn on 15/10/11.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "DanceViewTableCellTableViewCell.h"
#import "TrainDetailCellDefine.h"
#import "UIImageView+Cache.h"


@implementation DanceViewTableCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSlefSubViews];
    }
    return self;
}



- (void)layoutSlefSubViews {
    
    // 评论者头像
    CGRect iconFrame = CGRectMake(kMargin, kMargin, 3 * kBaseScale, 3 * kBaseScale);
    self.iconImageView = [[[UIImageView alloc] initWithFrame:iconFrame] autorelease];
    self.iconImageView.layer.cornerRadius = CGRectGetHeight(self.iconImageView.frame) / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    // 评论者名称
    CGRect nameFrame = CGRectMake(kMargin + CGRectGetMaxX(self.iconImageView.frame), CGRectGetMinY(self.iconImageView.frame) - kMargin / 2, 20 * kBaseScale, CGRectGetHeight(self.iconImageView.frame) / 2 + kMargin / 2);
    self.nameLabel = [[[UILabel alloc] initWithFrame:nameFrame] autorelease];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    // 评论内容
    CGRect conFrame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), kScreenWidth - CGRectGetMinX(self.nameLabel.frame) - kMargin, 1.5 * kBaseScale + kMargin / 2 - kMargin);
    self.contentLabel = [[[UILabel alloc] initWithFrame:conFrame] autorelease];
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    
    // 评论时间
    CGRect timeFrame = CGRectMake(kScreenWidth - 6 * kBaseScale - kMargin, CGRectGetMinY(self.iconImageView.frame), 6 * kMargin, CGRectGetHeight(self.nameLabel.frame) - kMargin / 2);
    self.timeLabel = [[[UILabel alloc] initWithFrame:timeFrame] autorelease];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    
    // 分隔条
    CGRect barFrame = CGRectMake(kMargin, CGRectGetMaxY(self.contentLabel.frame) + kMargin / 2, kScreenWidth - 2 * kMargin, 1);
    self.downBar = [[[UIView alloc] initWithFrame:barFrame] autorelease];
    self.downBar.backgroundColor = [UIColor grayColor];
    self.downBar.alpha = 0.3;
}


- (void)configureWithModel:(TrainRecommendModel *)model {
    [self.iconImageView JF_setImageWithURL:model.face placeHolderImage:@"default_head@2x.png"];
    self.contentLabel.text = model.content;
    self.nameLabel.text = model.nicheng;
    self.timeLabel.text = model.inserttime;
    
    // 通过内容长度 动态调整label 的高度
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat height = [self.contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * kMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dic context:nil].size.height;
    
    self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), kScreenWidth - CGRectGetMinX(self.nameLabel.frame) - kMargin, height - 2);
    self.downBar.frame = CGRectMake(kMargin, CGRectGetMaxY(self.contentLabel.frame) + kMargin / 2, kScreenWidth - 2 * kMargin, 1);
    
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.downBar];
}


- (void)configureListModel:(TrainListDetailComment *)model {
    if (model.iconImage.length == 0) {
        self.iconImageView.image = [UIImage imageNamed:@"default_head@2x.png"];
    } else {
         [self.iconImageView JF_setImageWithURL:model.iconImage placeHolderImage:@"default_head@2x.png"];
    }
   
    self.contentLabel.text = model.content;
    self.nameLabel.text = model.nickName;
    
    NSString *time = [model.publishTime substringWithRange:NSMakeRange(5, 11)];
    self.timeLabel.text = time;
    
    // 通过内容长度 动态调整label 的高度
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat height = [self.contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * kMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dic context:nil].size.height;
    
    self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), kScreenWidth - CGRectGetMinX(self.nameLabel.frame) - kMargin, height - 2);
    self.downBar.frame = CGRectMake(kMargin, CGRectGetMaxY(self.contentLabel.frame) + kMargin / 2, kScreenWidth - 2 * kMargin, 1);
    
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.downBar];

    
}


// 动态返回cell 的高度
- (CGFloat)returnCellHeight {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat height = [self.contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * kMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dic context:nil].size.height;
    
    return height + 2 * kBaseScale + kMargin;
}






- (void)dealloc
{
    self.downBar = nil;
    self.iconImageView = nil;
    self.nameLabel = nil;
    self.contentLabel = nil;
    self.timeLabel = nil;
    [super dealloc];
}

@end
