//
//  MovieListView.h
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListViewController.h"

@interface MovieListView : UITableViewCell


@property (nonatomic, retain)UILabel *titleLabel;//标题, 视频名字
@property (nonatomic, retain)UITextView *introduceTextView;//视频简介'
@property (nonatomic, retain)MovieListViewController *movieListTable;//相关视频列表


@end
