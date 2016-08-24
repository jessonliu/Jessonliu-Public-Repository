//
//  HH_AllViewController.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_AllViewController.h"

@interface HH_AllViewController ()<UIScrollViewDelegate>

@end

@implementation HH_AllViewController

- (void)setNameArr:(NSMutableArray *)nameArr {
    if (_nameArr != nameArr) {
        _nameArr = nameArr;
        [self viewDidLoad];
    }
}
- (void)setUserName:(NSMutableArray *)userName {
    if (_userName != userName) {
        _userName = userName;
        [self viewDidLoad];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView = [[[HH_HeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30*kOneWidth5s)] autorelease];
    [self.view addSubview:self.headerView];
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30*kOneHeight5s, kWidth, kHeight - CGRectGetMaxY(self.headerView.frame)-260*kOneHeight5s)] autorelease];
    self.scrollView.contentSize = CGSizeMake(kWidth *2, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    //添加课堂视图控制器
    self.otherVideoVC = [[[HH_OtherViedeoTableVC alloc] init] autorelease];
    self.otherVideoVC.tableView.frame = CGRectMake(0, 0, kWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.otherVideoVC.view];
    [self addChildViewController:self.otherVideoVC];
    self.otherVideoVC.videoNameArr =  self.nameArr;
    self.otherVideoVC.pathArr = self.videoPath;
    
    //添加评论视图控制器
    self.commentVC = [[[HH_CommentTableVC alloc] init] autorelease];
    self.commentVC.view.frame = CGRectMake(kWidth, 0, kWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.commentVC.view];
    [self addChildViewController:self.commentVC];

    
    
    //headerView两个button的点击事件
    [self.headerView.videoBtn addTarget:self action:@selector(ScrollViewForContentOfSet:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.commentBtn addTarget:self action:@selector(ScrollViewForContentOfSet:) forControlEvents:UIControlEventTouchUpInside];
    
}

//HeaderView的button响应事件
- (void)ScrollViewForContentOfSet:(UIButton *)senter{
    if (senter.tag == 201) {
        if (self.headerView.sliderView.frame.origin.x != senter.frame.origin.x) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                nil;
            }];
        }
        [senter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else  {
        if (self.headerView.sliderView.frame.origin.x != senter.frame.origin.x) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.scrollView.contentOffset = CGPointMake(kWidth, 0);
            } completion:^(BOOL finished) {
                nil;
            }];
        }
        [senter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }

}


#pragma mark - 视图偏移触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
        [self.headerView.videoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.headerView.commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        CGPoint point = scrollView.contentOffset;
        CGPoint point2 = self.headerView.sliderView.center;
        point2.x = point.x*150*kOneWidth5s/kWidth + 80*kOneWidth5s;
        self.headerView.sliderView.center = point2;
        
        if (point.x == 0) {
            [self.headerView.videoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        if (point.x == kWidth) {
            [self.headerView.commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/











@end
