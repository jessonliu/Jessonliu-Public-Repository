//
//  MovieListCell.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "MovieListCell.h"

@implementation MovieListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (UIView *)colorLine1 {
    if (!_colorLine1) {
        self.colorLine1 = [[UIView new] autorelease];
    }
    return [[_colorLine1 retain] autorelease];
}

- (UIView *)colorLine2 {
    if (!_colorLine2) {
        self.colorLine2 = [[UIView new] autorelease];
    }
    return [[_colorLine2 retain] autorelease];
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel new] autorelease];
    }
    return [[_nameLabel retain] autorelease];
}

-(UIImageView *)playImageView {
    if (!_playImageView) {
        self.playImageView = [[UIImageView new] autorelease];
        _playImageView.image = [UIImage imageNamed:@"dd_item_playicon"];
    }
    return [[_playImageView retain] autorelease];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.colorLine1];
        [self addSubview:self.colorLine2];
        [self addSubview:self.nameLabel];
        [self addSubview:self.playImageView];
    }
    return self;
}



- (void)dealloc
{
    self.videoModel = nil;
    self.colorLine1 = nil;
    self.colorLine2 = nil;
    self.nameLabel = nil;
    self.playImageView = nil;
    [super dealloc];
}






@end
