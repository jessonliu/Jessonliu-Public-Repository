//
//  DancingViewCell.m
//  DancingDemol
//
//  Created by lanouhn on 15/10/10.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#define kScreen [UIScreen mainScreen].bounds.size

#import "DancingViewCell.h"
#import "DancingCellModel.h"
#import "UIImageView+Cache.h"
#define kWidthScreen [UIScreen mainScreen].bounds.size.width
#define kWidthPic ([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3.0
@interface DancingViewCell ()

@end


@implementation DancingViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1. 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"headerImage"];
        iconView.layer.cornerRadius = 17;
        iconView.layer.masksToBounds = YES;
        [self addSubview:iconView];
        self.headerI = iconView;
        
        //2. 昵称
        UILabel *nameLab = [[[UILabel alloc] init] autorelease];
        //        nameLab.textColor = [UIColor grayColor];
        nameLab.text = @"夕阳西下, 断肠人在天涯";
        //昵称字体及大小
        nameLab.font = [UIFont fontWithName:@"Arial" size:12];
        nameLab.textAlignment = NSTextAlignmentLeft;
        self.nameL = nameLab;
        [self.contentView addSubview:nameLab];
        
        
        //3. 定位
        UILabel *locationLab = [[[UILabel alloc] init] autorelease];
        
        locationLab.textColor = [UIColor grayColor];
        locationLab.text = @"河南省郑州市高新区莲花街";
        //位置字体及大小
        locationLab.font = [UIFont fontWithName:@"Arial" size:7];
        locationLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:locationLab];
        self.locationL = locationLab;
        
        //4. 发表时间
        UILabel *timeLab = [[[UILabel alloc] init] autorelease];
        
        timeLab.textColor = [UIColor grayColor];
        timeLab.text = @"2015-09-30";
        //时间字体及大小
        timeLab.font = [UIFont fontWithName:@"Arial" size:7];
        timeLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLab];
        self.timeL = timeLab;
        
        //5. 正文
        UILabel *contentLab = [[[UILabel alloc] initWithFrame:CGRectMake(10 * kScreen.width / 320, CGRectGetMaxY(self.headerI.frame) + 10 * kScreen.width / 320, kScreen.width - 20 * kScreen.width / 320, 100)] autorelease];
//        contentLab.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0];
        contentLab.numberOfLines = 0;
        contentLab.lineBreakMode = NSLineBreakByCharWrapping;
        contentLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:contentLab];
        self.contentL = contentLab;
        
        //6. 签到
        UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [signInBtn setImage:[UIImage imageNamed:@"sqArrow@2x"] forState:UIControlStateNormal];
        
        [signInBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signInBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -50)];
        [signInBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [signInBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 22)];
        //签到字体及大小
        [signInBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [self addSubview:signInBtn];
        self.signInV = signInBtn;
        
        //7. 点赞
        UIButton *interestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        interestBtn.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0];
        interestBtn.layer.cornerRadius = 5;
        [interestBtn setImage:[UIImage imageNamed:@"sqPraise@2x"] forState:UIControlStateNormal];
        
        [interestBtn setTitle:@"1" forState:UIControlStateNormal];
        [interestBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
        [interestBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [interestBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -2)];
        [interestBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        
        [self addSubview:interestBtn];
        self.interestV = interestBtn;
        
        //8. 评论
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0];
        commentBtn.layer.cornerRadius = 5;
        [commentBtn setImage:[UIImage imageNamed:@"sqComment@2x"] forState:UIControlStateNormal];
        
        [commentBtn setTitle:@"0" forState:UIControlStateNormal];
        [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
        [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -2)];
        [commentBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        
        [self addSubview:commentBtn];
        self.commentV = commentBtn;
        
        //9. 分享
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0];
        shareBtn.layer.cornerRadius = 5;
        [shareBtn setImage:[UIImage imageNamed:@"sqShare@2x"] forState:UIControlStateNormal];
        [self addSubview:shareBtn];
        self.shareV = shareBtn;
        
        
        
    }
    return self;
}


- (void)setModel:(DancingCellModel *)model {
    if (_model != model) {
        _model = model;
    }
    //1. 头像
    [self.headerI JF_setImageWithURL:model.memberAvatars placeHolderImage:@"default_indexpic_2x.png"];
    [self.headerI setFrame:CGRectMake(10 * kScreen.width / 320.0, 10, 35 * kScreen.width / 320.0, 35 * kScreen.width / 320.0)];
    //2. 昵称
    self.nameL.text = model.memberName;
    [self.nameL setFrame:CGRectMake(CGRectGetMaxX(self.headerI.frame) + 10 * kScreen.width / 320.0, CGRectGetMidY(self.headerI.frame) - 5, 120, 10)];
    //3. 定位
    self.locationL.text = model.location;
    [self.locationL setFrame:CGRectMake(CGRectGetMaxX(self.nameL.frame) + 10 * kScreen.width / 320.0, CGRectGetMidY(self.nameL.frame) - 5, 80, 10)];
    //4. 发表时间
    self.timeL.text = model.createTime;
    [self.timeL setFrame:CGRectMake(CGRectGetMaxX(self.locationL.frame) + 10 * kScreen.width / 320.0, CGRectGetMidY(self.locationL.frame) - 5, 50, 10)];
    //5. 正文
    
    self.contentL.text = model.contents;
    CGFloat height = [self.contentL.text boundingRectWithSize:CGSizeMake(kScreen.width - 20 * kScreen.width / 320.0, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    self.contentL.frame = CGRectMake(10 * kScreen.width / 320.0, CGRectGetMaxY(self.headerI.frame) + 10 * kScreen.width / 320.0, kScreen.width - 20 * kScreen.width / 320, height);
    //6. 签到
    [self.signInV setTitle:model.sectionName forState:UIControlStateNormal];
    [self.signInV setFrame:CGRectMake(10 * kScreen.width / 320.0, CGRectGetMaxY(self.contentL.frame) + 10, 60, 20)];
    //7. 点赞
    [self.interestV setTitle:(NSString *)model.jointNum forState:UIControlStateNormal];
    [self.interestV setFrame:CGRectMake(220 * kScreen.width / 320.0, CGRectGetMaxY(self.contentL.frame) + 10, 30, 20)];
    //8. 评论
    [self.commentV setTitle:model.commentNum forState:UIControlStateNormal];
    [self.commentV setFrame:CGRectMake(255 * kScreen.width / 320.0, CGRectGetMaxY(self.contentL.frame) + 10, 30, 20)];
    //9. 分享
    [self.shareV setTitle:(NSString *)model.shareNum forState:UIControlStateNormal];
    [self.shareV setFrame:CGRectMake(290 * kScreen.width / 320.0, CGRectGetMaxY(self.contentL.frame) + 10, 20, 20)];
    //10. 正文图片
    
    if (self.model.contentImage.count != 0) {//有配图
        NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:1];
        if (self.model.contentImage.count >= 3) {
            for (int i = 0; i < 3; i++) {
                NSDictionary *dic = self.model.contentImage[i];
                NSString *imgStr = [NSString stringWithFormat:@"%@%@%@%@", dic[@"host"], dic[@"dir"], dic[@"filepath"], dic[@"filename"]];
                self.model.width = dic[@"width"];
                self.model.height = dic[@"height"];
                [imgArr addObject:imgStr];
            }
        } else {
            for (NSDictionary *dic in self.model.contentImage) {
                NSString *imgStr = [NSString stringWithFormat:@"%@%@%@%@", dic[@"host"], dic[@"dir"], dic[@"filepath"], dic[@"filename"]];
                self.model.width = dic[@"width"];
                self.model.height = dic[@"height"];
                [imgArr addObject:imgStr];
            }
        }
        static CGFloat x = 10;
        for (int i = 0; i < imgArr.count; i++) {
            x = 10 * (i + 1) + kWidthPic * i;
           self.pictureV = [[[UIImageView alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.contentL.frame) + 10, kWidthPic, kWidthPic *self.model.height.integerValue * 1.0 / self.model.width.integerValue)] autorelease];
//            self.pictureV.backgroundColor = [UIColor magentaColor];
            [self.contentView addSubview:self.pictureV];
            [self.pictureV JF_setImageWithURL:imgArr[i] placeHolderImage:@"default_indexpic_2x.png"];
        }

        _cellHeight = CGRectGetMaxY(self.pictureV.frame) + 10;
        [self.signInV setFrame:CGRectMake(10 * kScreen.width / 320.0, CGRectGetMaxY(self.pictureV.frame) + 10, 60, 20)];
        [self.interestV setFrame:CGRectMake(220 * kScreen.width / 320.0, CGRectGetMaxY(self.pictureV.frame) + 10, 30, 20)];
        [self.commentV setFrame:CGRectMake(255 * kScreen.width / 320.0, CGRectGetMaxY(self.pictureV.frame) + 10, 30, 20)];
        [self.shareV setFrame:CGRectMake(290 * kScreen.width / 320.0, CGRectGetMaxY(self.pictureV.frame) + 10, 20, 20)];
    } else {//无配图
        [self.pictureV removeFromSuperview];
        _cellHeight = CGRectGetMaxY(self.contentL.frame) + 10;
    }
    
}

-(float)returnCellHeigt
{
    CGFloat height = [self.contentL.text boundingRectWithSize:CGSizeMake(kScreen.width - 20 * kScreen.width / 320.0, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    if (self.model.contentImage.count){
        
        return height +self.pictureV.frame.size.height +120;
    }
    return height + 100;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    self.model = nil;
    self.headerI = nil;
    self.nameL = nil;
    self.locationL = nil;
    self.timeL = nil;
    self.contentL = nil;
    self.pictureV = nil;
    [super dealloc];
}

@end
