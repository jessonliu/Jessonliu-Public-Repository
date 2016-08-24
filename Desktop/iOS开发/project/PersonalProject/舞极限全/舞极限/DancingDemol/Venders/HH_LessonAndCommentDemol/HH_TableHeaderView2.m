//
//  HH_TableHeaderView2.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_TableHeaderView2.h"

@implementation HH_TableHeaderView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (UILabel *)likeCountLabel {
    if (!_likeCountLabel) {
        self.likeCountLabel = [[[UILabel alloc] initWithFrame:CGRectMake(210*kOneWidth5s, 40*kOneHeight5s, 40*kOneWidth5s, 20*kOneHeight5s)] autorelease];
        _likeCountLabel.textAlignment = NSTextAlignmentRight;
        _likeCountLabel.textColor = [UIColor redColor];
        _likeCountLabel.font = [UIFont systemFontOfSize:16];
    }
    return _likeCountLabel;
}

- (UILabel *)perLikeLabel {
    if (!_perLikeLabel) {
        self.perLikeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(250*kOneWidth5s, 40*kOneHeight5s, 60*kOneWidth5s, 20*kOneHeight5s)] autorelease];
        _perLikeLabel.text = @"人喜欢";
        _perLikeLabel.font = [UIFont systemFontOfSize:14];
        _perLikeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _perLikeLabel;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.iconImagesView];
        [self addSubview:self.likeCountLabel];
        [self addSubview:self.perLikeLabel];
        
        
    }
    return self;
}


@end
