//
//  DanceListCell.m
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "DanceListCell.h"
#import "MacroValue.h"
@implementation DanceListCell


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12*kOneWidth5s, 119*kOneHeight5s, self.frame.size.width-20*kOneWidth5s, 20*kOneHeight5s)] autorelease];
        _titleLabel.font = [UIFont systemFontOfSize:13 weight:30];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return [[_titleLabel retain] autorelease];
}

- (UILabel *)hitsLabel {
    if (!_hitsLabel) {
        self.hitsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25*kOneWidth5s, 135*kOneHeight5s, 60*kOneWidth5s, 20*kOneHeight5s)] autorelease];
        _hitsLabel.font = [UIFont systemFontOfSize:13 weight:10];
        _hitsLabel.textColor = [UIColor whiteColor];
    }
    return [[_hitsLabel retain] autorelease];
}

- (UIImageView *)listImageView {
    if (!_listImageView) {
        self.listImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        _listImageView.backgroundColor = [UIColor brownColor];
    }
    return [[_listImageView retain] autorelease];
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.listImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.hitsLabel];
        
        UIImageView *temp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dd_item_playicon@2x"]];
        temp.frame = CGRectMake(8*kOneWidth5s, 137*kOneHeight5s, 15*kOneWidth5s, 15*kOneHeight5s);
        [self addSubview:temp];
        [temp release];
        
    }
    return self;
}



- (void)dealloc
{
    self.listImageView = nil;
    self.titleLabel = nil;
    self.hitsLabel = nil;
    [super dealloc];
}

@end
