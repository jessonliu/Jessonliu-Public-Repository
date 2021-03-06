//
//  TrainScrollController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainScrollController.h"
#import "TrainTitleModel.h"
#import "TrainListController.h"
#import "TrainTitleDefine.h"
#import "UIRecommendListController.h"

@interface TrainScrollController ()<UIScrollViewDelegate>

@end

@implementation TrainScrollController

- (void)dealloc
{
//    self.array = nil;
    self.trainScrollView = nil;
    [super dealloc];
}

- (void)loadView {
    [super loadView];
   self.trainScrollView = [[[UIScrollView alloc] init] autorelease];
    self.trainScrollView.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - 64 - kHeight_View);
    self.trainScrollView.bounces = NO;
   self.trainScrollView.showsHorizontalScrollIndicator = NO;
    self.trainScrollView.showsVerticalScrollIndicator = NO;
    self.trainScrollView.pagingEnabled = YES;
    self.trainScrollView.directionalLockEnabled = YES;
    
    self.trainScrollView.delegate = self;
    self.view = self.trainScrollView;
}


// 检测scrollView 的偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(senderContentOffSize:)]) {
        [self.delegate senderContentOffSize:scrollView.contentOffset.x];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)getDataArray:(NSMutableArray *)array {
     //设置scrollView的contentSize
    self.trainScrollView.contentSize =CGSizeMake([UIScreen mainScreen].bounds.size.width * array.count, CGRectGetHeight(self.trainScrollView.frame));
    
    // for 循环创建scrollView 上的每一个tableView
    for (int i = 0; i < array.count; i ++) {
        if (i != 0) {
        CGRect frame = CGRectMake(kScreem_Width * i, 0, kScreem_Width, kScreem_Height- 94 - 44);
        TrainListController *listVC = [[TrainListController alloc] init];
        listVC.tableView.frame = frame;
         listVC.tableView.tag = 100 + i;
            listVC.titID = ((TrainTitleModel *)array[i]).titleID;
            [listVC getTitleID:((TrainTitleModel *)array[i]).titleID];
        [self addChildViewController:listVC];
        [self.trainScrollView addSubview:listVC.tableView];
        [listVC release];
            
        } else {
            
            UIRecommendListController *recommendVC = [[UIRecommendListController alloc] init];
            recommendVC.tableView.frame = CGRectMake(0, 0, kScreem_Width, kScreem_Height - 94 - 44);
            [self addChildViewController:recommendVC];
            [self.trainScrollView addSubview:recommendVC.tableView];
            [recommendVC release];
            
        }
    }
}


@end
