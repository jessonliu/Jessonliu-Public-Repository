//
//  HH_TableHeaderView1.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_TableHeaderView1.h"

@implementation HH_TableHeaderView1


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 //上面有一个titleLabel 一个简介TextView 一个作者头像ImageView  一个作者名字Label
 
 @property (nonatomic, strong)UILabel *titleLabel;
 @property (nonatomic, strong)UITextView *introduceTextView;
 @property (nonatomic, strong)UIImageView *autoIconImageView;
 @property (nonatomic, strong)UILabel *autoName;
*/







- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10*kOneWidth5s, 10*kOneHeight5s, kWidth-15*kOneWidth5s, 40*kOneHeight5s)] autorelease];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return _titleLabel;
}

- (UITextView *)introduceTextView {
    if (!_introduceTextView) {
        self.introduceTextView = [[[UITextView alloc] initWithFrame:CGRectMake(10*kOneWidth5s, CGRectGetHeight(self.titleLabel.frame) + 10*kOneHeight5s, kWidth- 15*kOneWidth5s, 50*kOneHeight5s)] autorelease];
        _introduceTextView.editable = NO;
        _introduceTextView.showsVerticalScrollIndicator = NO;
        _introduceTextView.textColor = [UIColor grayColor];
        _introduceTextView.font = [UIFont systemFontOfSize:10];

    }
    return _introduceTextView;
}


- (UIImageView *)autoIconImageView {
    if (!_autoIconImageView) {
        self.autoIconImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(15*kOneWidth5s, CGRectGetMaxY(self.introduceTextView.frame) + 10*kOneHeight5s, 35*kOneWidth5s, 35*kOneHeight5s)] autorelease];
        _autoIconImageView.layer.cornerRadius = 17.5;
        _autoIconImageView.layer.masksToBounds = YES;

    }
    return _autoIconImageView;
}

- (UILabel *)autoName {
    if (!_autoName) {
        self.autoName = [[[UILabel alloc] initWithFrame:CGRectMake(60*kOneWidth5s, CGRectGetMaxY(self.introduceTextView.frame) + 13*kOneHeight5s, 150*kOneWidth5s, 30*kOneHeight5s)] autorelease];
        _autoName.font = [UIFont systemFontOfSize:18];

    }
    return _autoName;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.introduceTextView];
        [self addSubview:self.autoName];
        [self addSubview:self.autoIconImageView];

    }
    return self;
}




@end
