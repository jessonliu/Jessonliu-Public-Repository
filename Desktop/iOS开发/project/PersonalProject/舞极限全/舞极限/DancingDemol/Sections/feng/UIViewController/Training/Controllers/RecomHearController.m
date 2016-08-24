//
//  RecomHearController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/28.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "RecomHearController.h"
#import "TrainDetailCellDefine.h"
#import "ReHeadBtnViewController.h"

#define kImageCount 2

@interface RecomHearController ()

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *titleArray;

@end

@implementation RecomHearController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArray = @[@"舞动全球", @"街舞涂鸦", @"魅力无限"];
    [self layoutHeaderScrollView];
    [self layoutBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutHeaderScrollView {
    self.headerScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_HeaderScorllView)] autorelease];
    self.headerScrollView.contentSize = CGSizeMake(2 * kScreenWidth, self.headerScrollView.bounds.size.height);
    self.headerScrollView.delegate = self;
    self.headerScrollView.pagingEnabled = YES;
    
    
    // 灰玻璃效果
    UIImageView *grayImageA = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_HeaderScorllView)] autorelease];
    grayImageA.image = [UIImage imageNamed:@"picflow_title_bg@2x副本"];
    [self.headerScrollView addSubview:grayImageA];
    
    UIImageView *grayImageB = [[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kHeight_HeaderScorllView)] autorelease];
    grayImageB.image = [UIImage imageNamed:@"picflow_title_bg@2x副本"];
    [self.headerScrollView addSubview:grayImageB];
    
    
    
    UILabel *aLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 8 * kBaseScale, kScreenWidth - 40, 40)] autorelease];
    aLabel.text = @"舞动全城";
    aLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:22];
    
    aLabel.textColor = [UIColor whiteColor];
    [self.headerScrollView addSubview:aLabel];
    
    
    UILabel *bLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20 + kScreenWidth, 8 * kBaseScale, kScreenWidth - 40, 40)] autorelease];
    bLabel.text = @"街舞涂鸦";
    bLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:22];
    bLabel.textColor = [UIColor whiteColor];
    [self.headerScrollView addSubview:bLabel];
    
    
    
    self.firstImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.headerScrollView.bounds.size.height)] autorelease];
    self.firstImage.image = [UIImage imageNamed:@"jiewu"];
    
    self.secondImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.headerScrollView.bounds.size.height)] autorelease];
    self.secondImage.image = [UIImage imageNamed:@"tuya"];
    
    
    self.pageControl  = [[[UIPageControl alloc] initWithFrame:CGRectMake((kScreenWidth - 3 * kBaseScale) / 2, CGRectGetMaxY(self.headerScrollView.frame) - 2 * kMargin, 3 * kBaseScale, 2 * kMargin)] autorelease];
    self.pageControl.numberOfPages = 2;
//    [self addTimerToScrollView];
    self.pageControl.userInteractionEnabled = NO;
    
    
    [self.view addSubview:self.secondImage];
    [self.view addSubview:self.firstImage];
    [self.view addSubview:self.headerScrollView];
    [self.view addSubview:self.pageControl];
    
    
}





/*
 - (void)viewLayoutScrollView:(NSInteger)imageNumber {
 // 灰玻璃效果
 UIImageView *grayImageA = [[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * imageNumber, 0, kScreenWidth, kHeight_HeaderScorllView)] autorelease];
 grayImageA.image = [UIImage imageNamed:@"picflow_title_bg@2x副本"];
 [self.headerScrollView addSubview:grayImageA];
 
 
 UILabel *aLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20 + kScreenWidth * imageNumber, 8 * kBaseScale, kScreenWidth - 40, 40)] autorelease];
 aLabel.text = self.titleArray[imageNumber];
 aLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:22];
 
 aLabel.textColor = [UIColor whiteColor];
 [self.headerScrollView addSubview:aLabel];
 
 self.firstImage = [[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.headerScrollView.bounds.size.height)] autorelease];
 self.firstImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"HeaderScrollView%ld", imageNumber]];
 }
 
 */
// 页眉五个button
- (void )layoutBtn {
    NSArray *array = @[@"MV", @"爵士", @"HIPHOP", @"芭蕾舞", @"现代舞"];
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake( 0, self.headerScrollView.bounds.size.height, kScreenWidth, 44)];
    [self.view addSubview:BGView];
    
    for (int i = 0; i < 5; i++) {
        ReHeadBtnViewController *headerBtnVC = [[ReHeadBtnViewController alloc] init];
        headerBtnVC.view.frame = CGRectMake(i * kScreenWidth / 5 , 0, kScreenWidth / 5, 44);
        headerBtnVC.titleLabel.text = array[i];
        headerBtnVC.btn.tag = 200 + i;
        [headerBtnVC.btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"hearBtn_%d.jpg", i]] forState:UIControlStateNormal];
        [self addChildViewController:headerBtnVC];
        [BGView addSubview:headerBtnVC.view];
        
    }
    
}


//- (void)handleButton:(UIButton *)button {
//    NSLog(@"hahhhha");
//}


#pragma mark --- UIScrollViewDelegate
// 开始拖拽时停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

// 只要拖拽就会触发, 此时scrollView偏移量发生变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= kScreenWidth) {
        [UIView animateWithDuration:1 animations:^{
            
            self.firstImage.alpha =1 - scrollView.contentOffset.x / kScreenWidth;
            self.pageControl.currentPage = scrollView.contentOffset.x / 320;
            
        }];
        
    }
}


// 停止拖拽时添加定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self addTimerToScrollView];
}

// 添加定时器
- (void)addTimerToScrollView {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage {
    NSInteger page = 0;
    if (self.pageControl.currentPage == kImageCount - 1) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    [UIView animateWithDuration:1 animations:^{
        CGPoint offSet = CGPointMake(self.headerScrollView.bounds.size.width *  page, 0);
        [self.headerScrollView setContentOffset:offSet animated:NO];
    }];
    
}





- (void)dealloc
{
    self.titleArray = nil;
    self.pageControl = nil;
    self.timer = nil;
    self.firstImage = nil;
    self.secondImage = nil;
    self.headerScrollView = nil;
    [super dealloc];
}

@end
