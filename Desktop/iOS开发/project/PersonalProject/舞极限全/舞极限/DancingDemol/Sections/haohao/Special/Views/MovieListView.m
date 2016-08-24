//
//  MovieListView.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "MovieListView.h"

@implementation MovieListView


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel new] autorelease];
    }
    return [[_titleLabel retain] autorelease];
}

- (UITextView *)introduceTextView {
    if (!_introduceTextView) {
        self.introduceTextView = [[UITextView new] autorelease];
    }
    return [[_introduceTextView retain] autorelease];
}

-(MovieListViewController *)movieListTable {
    if (!_movieListTable) {
        self.movieListTable = [[MovieListViewController new] autorelease];
    }
    return [[_movieListTable retain] autorelease];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.introduceTextView];
        [self addSubview:self.movieListTable.tableView];
    }
    return self;
}


- (void)dealloc
{
    self.titleLabel = nil;
    self.introduceTextView = nil;
    self.movieListTable = nil;
    [super dealloc];
}

@end
