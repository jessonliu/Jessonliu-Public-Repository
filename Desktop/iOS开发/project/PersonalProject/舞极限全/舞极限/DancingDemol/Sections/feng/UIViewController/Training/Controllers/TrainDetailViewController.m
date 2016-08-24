//
//  TrainDetailViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/9/22.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "TrainDetailViewController.h"
#import "BasicNVC.h"
#import "TrainDetailCellDefine.h"
#import "movieStateView.h"
#import "UIImageView+Cache.h"
#import "danceViewController/DanceViewController.h"
#import "ThumbView.h"
#import "SingleTon.h"
#import "NetWorkManager.h"
#import "TrainDetailModel.h"
#import "HBCDetailModel.h"
#import "HBCVideoModel.h"
#import "HBCComment.h"
#import "HBCLikePerModel.h"
#import "HH_AllViewController.h"
#import "MBProgressHUD.h"
#import "WubaListDetailViewController.h"


@interface TrainDetailViewController () <HH_OtherViedeoTableVCDelegate>
{
    BOOL _played;
    BOOL _touch;
    BOOL _screenBtn;
    NSDateFormatter *_dateFormatter;
}


@property (nonatomic, retain) NSString * totalTime;

@property (nonatomic, retain) UIButton *stateButton;
@property (nonatomic, retain) id playbackTimeObserver;
@property (nonatomic, retain) NSTimer *HiTimer;
@property (nonatomic, retain) NSMutableArray *videoSourse; // 存储视频数据
@property (nonatomic, retain) NSMutableArray *likePerIconSourse;
// 存储喜欢人头像数据
@property (nonatomic, retain) NSMutableArray *commentSource; // 存储评论内容

@property (nonatomic, assign) CGFloat currentProgress; // 当前进度条
@property (nonatomic, assign) CGFloat cachesProgress;  // 缓存进度条

@property (nonatomic, retain) HBCDetailModel *hbcDetail; // 存数modeo类
@property (nonatomic, assign) NSInteger numberCount;

@end

@implementation TrainDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 判断数据来源然后进行请求解析 创建相应的控件
    [self judgeDataSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendVideonPlayURL:) name:@"SendVideoURLStr" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bianchengling) name:@"bianchengling" object:nil];
 
    
}
- (void)bianchengling {
    self.numberCount = 0;
}

// 视频中心按钮
- (UIButton *)stateButton {
    if (!_stateButton) {
        self.stateButton = [[[UIButton alloc] initWithFrame:CGRectMake(13.5 * kBaseScale, 6.5 * kBaseScale, 5 * kBaseScale, 5 * kBaseScale)] autorelease];
        [self.stateButton setImage:[UIImage imageNamed:@"dd_item_playicon@2x副本"] forState:UIControlStateNormal];
        [self.stateButton addTarget:self action:@selector(stateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[_stateButton retain] autorelease];
}

//stateButton 点击事件
- (void)stateButtonAction:(UIButton *)btn {
    [self useTimerToHiddenStateView];
    // 让视频显示图的图片等于空
    self.movieImage.image = nil;
    
    movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
    stateView.hidden = NO;
    
    if (!_played) {
        [self.dancePlayer play];
        [stateView.stateBtn setImage:[UIImage imageNamed:@"Player_暂停@2x"] forState:UIControlStateNormal];
        self.stateButton.hidden = YES;
    } else {
        [self.dancePlayer pause];
        [stateView.stateBtn setImage:[UIImage imageNamed:@"dd_item_playicon@2x"] forState:UIControlStateNormal];
        self.stateButton.hidden = NO;
    }
    _played = !_played;
    btn.hidden = YES;
    [self useTimerToHiddenStateView];
}


// 视频属性控制条的背景图 (未启用)
- (void)addPlayerBarGBImage {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 20 * kBaseScale, kScreenWidth - 2 * kMargin, 1)] autorelease];
    imageView.alpha = 0.4;
    imageView.image = [UIImage imageNamed:@"picflow_title_bg@2x副本"];
    [self.view addSubview:imageView];
}


// 添加视频显示图片
- (void)addMovieView {
    self.movieImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 18 * kBaseScale)] autorelease];
    self.movieImage.userInteractionEnabled = YES;
    
    if (self.viewTag == 0) {
        [self.movieImage JF_setImageWithURL:self.model.thumb placeHolderImage:@"default_indexpic_2x.png"];
        } else if (200 <=self.viewTag && self.viewTag <= 204) {
            [self.movieImage JF_setImageWithURL:self.HeaderBtnCellImageViewName placeHolderImage:@"default_indexpic_2x.png"];
    }
    else {
        [self.movieImage JF_setImageWithURL:self.listModel.imageName placeHolderImage:@"default_indexpic_2x.png"];
    }
    
    
    [self.view addSubview:self.movieImage];
    
    // 给player 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    // 设置轻拍的次数
    tapGesture.numberOfTapsRequired = 1;
    // 设置触摸的点数
    tapGesture.numberOfTouchesRequired = 1;
    // 2.将手势添加到视图上
    [self.movieImage addGestureRecognizer:tapGesture];
    // 3.释放
    [tapGesture release];
}

// 手势触发事件
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer {
    movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
    // 判断触摸的Bool值来确定是否隐藏 stareView
    
    if (!_touch) {
        stateView.hidden = NO;
        // 使用定时器隐藏stateView
        [self useTimerToHiddenStateView];
    } else {
        stateView.hidden = YES;
    }
    _touch = !_touch;
}

// 自定义导航条
- (void)customizationNabigationBar {
    self.navigationItem.title = @"详情";
}


// 解析完数据添加相关控件
- (void)addSubView:(NSString *)str {
//    NSLog(@"%@", str);
    // 添加视频控件
    [self addDancePlayer:str];
    //    [self addPlayerBarGBImage];
    // 添加视频显示图
    [self addMovieView];
    // 添加player 上的button
    [self.view addSubview:self.stateButton];
    // 添加视频状态条
    [self addMovieStateBar];
    
//        [self addBTN];
    
    // 自定义导航条
    //    [self configureNavigationBarContent];
}



// 测试按钮 (调试使用)
/*

- (void)addBTN {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 80, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(handlebTNaCITON) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)handlebTNaCITON{
    
     AVPlayerItem *playerItem2 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://7s1sjv.com2.z0.glb.qiniucdn.com/81FD76E9-4ABC-22E8-6D31-009F67BA2B52.mp4?e=1444743315&token=KS01Ll3g_TIIFDGeR2Ar2adyuxB5LMvgDFgF_4L3:t9mRrYq8RwNXaUhgP4Yzy91A1pI="]];
    
    [self.dancePlayer replaceCurrentItemWithPlayerItem:playerItem2];
//    [self.dancePlayer play];

//    NSLog(@"aksdfjlakdsfj");
}

*/


// 视频控件设置
- (void)addDancePlayer:(NSString *)movieStr {
    NSURL *movieURL = [NSURL URLWithString:movieStr];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:movieURL];
    self.dancePlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.dancePlayer];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    self.layer.frame = CGRectMake(0, 0, kScreenWidth, kBaseScale * 18);
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:self.layer];
    
}



// 使用定时器隐藏stateView
- (void)useTimerToHiddenStateView {
    [self.HiTimer invalidate];
    movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
    if (!stateView.hidden) {
        
        // 设置定时器, 三秒隐藏stateView
        self.HiTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil  repeats:YES];
    }
}

// KVO 播放器检测机制
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary *)change context:(nullable void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    NSLog(@"%@", playerItem);
    [SingleTon sendDataSingleton].temPlayer = self.dancePlayer;  // 视频播放器传给单例
    [SingleTon sendDataSingleton].playState = _played;   // 视频播放器的播放暂停状态转给单例
    //   CGFloat a = [SingleTon sendDataSingleton].mar;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            //                CMTime time = CMTimeMakeWithSeconds(0, self.dancePlayer.currentTime.timescale);
            //                [self.dancePlayer seekToTime:time];
            
            
            //            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            [SingleTon sendDataSingleton].videoSecond = totalSecond;
            self.totalTime = [NSString stringWithFormat:@"%@", [self convertTime:totalSecond]];// 转换成播放时间
            movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
            stateView.timeLable.text = [NSString stringWithFormat:@"00:00 / %@", _totalTime];
            //            [self customVideoSlider:duration];// 自定义UISlider外观
            //            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback:self.playerItem timgNumer:totalSecond];// 监听播放状态
            
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        self.cachesProgress = timeInterval / totalDuration;
        // 设置缓冲条
        movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
        [stateView.cushionView  setProgress:self.cachesProgress animated:YES];
        
        // 检测缓冲条与进度条
        //        [self monitorProgressView:timeInterval curTime:self.currentProgress * totalDuration];
        
    }
    
}

// 时时检测 当前播放时间
- (void)monitoringPlayback:(AVPlayerItem *)playerItem timgNumer:(CGFloat)timeNumber{
    __block TrainDetailViewController * weakSelf = self;

    self.playbackTimeObserver = [self.dancePlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        CGFloat currentSecond = CMTimeGetSeconds(time); // 当前的时间
        CGFloat  total = CMTimeGetSeconds([self.dancePlayer.currentItem duration]); // 总时间
        if (currentSecond) {
//            [SingleTon sendDataSingleton].currentTime = currentSecond; // 视频当前播放时间 赋给单例
            
            NSString *timeString = [weakSelf convertTime:currentSecond];
            
            //        NSLog(@"%@------", timeString);
            // 给timeLabel赋值
            movieStateView *stateView = (movieStateView *)[weakSelf.view viewWithTag:300];
            stateView.timeLable.text = [NSString stringWithFormat:@"%@ / %@", timeString, _totalTime];
            // 滑块当前的进度
            stateView.slider.value = currentSecond / total;
            stateView.slider.tag = timeNumber;
            [stateView.slider addTarget:weakSelf action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            [MBProgressHUD hideHUDForView:weakSelf.movieImage animated:YES];
            
            // 播放到最后一秒 返回开始位置, 并暂停
            if (currentSecond == total) {
//                [weakSelf endPlayeBackBeginAndLetPlayerStop:currentSecond totalTime:total];
                CMTime time = CMTimeMakeWithSeconds(0, self.dancePlayer.currentTime.timescale);
                [self.dancePlayer seekToTime:time];
                 [self.dancePlayer pause];
                self.stateButton.hidden = NO;  // 视频中心button 显示
                movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
                [stateView.stateBtn setImage:[UIImage imageNamed:@"跳吧播放详情_开始@2x"] forState:UIControlStateNormal];  // 视频属性条 的button 处于暂停状态
                stateView.slider.value = 0;
                 _played = !_played;
            }
        }
        
    }];
   
}


// 滑动滑块的事件
- (void)sliderAction:(UISlider *)slider {
    [self.dancePlayer pause];
       CMTime time = CMTimeMakeWithSeconds(slider.value * slider.tag, self.dancePlayer.currentTime.timescale);
    [self.dancePlayer seekToTime:time];
    if (_played) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dancePlayer play];
             });
    }

   
}



// 判断缓冲条 与 当前进度条是否相等, 如果不相等, 缓冲条大于进度条, 切处于播放状态 , 让视频自动调用 播放视频;
// cushionTime  缓冲时间
// curTime 当前时间

- (void)monitorProgressView:(CGFloat)cushionTime curTime:(CGFloat)curTime {
    if (_played && (cushionTime > (curTime + 3))) {
//        [self.dancePlayer play];
    }
}


// 检测播放, 如果播放完成 返回开始位置, 并暂停播放
- (void)endPlayeBackBeginAndLetPlayerStop:(CGFloat)curTime totalTime:(CGFloat)totalTime{
//    if (curTime > (totalTime - 2)) {
    
        //    }
}


// 转换为秒
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}


// 缓冲相关方法
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.dancePlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


// 添加视频状态条
- (void)addMovieStateBar {
    movieStateView *stateView = [[[movieStateView alloc] initWithFrame:CGRectMake(0, 14 * kBaseScale - kMargin / 2, kScreenWidth, 4 * kBaseScale)] autorelease];
    stateView.hidden = YES;
    stateView.tag = 300;
    
    [stateView.screenStateBtn addTarget:self action:@selector(screenStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [stateView.stateBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stateView];
}

// stateView上的开始暂停按钮的点击时间
- (void)handleAction:(UIButton *)btn {
    self.movieImage.image = nil;
    if (!_played) {
        [self.dancePlayer play];
        [btn setImage:[UIImage imageNamed:@"Player_暂停@2x"] forState:UIControlStateNormal];
        self.stateButton.hidden = YES;
        
    } else {
        [self.dancePlayer pause];
        [btn setImage:[UIImage imageNamed:@"跳吧播放详情_开始@2x"] forState:UIControlStateNormal];
        self.stateButton.hidden = NO;
    }
    _played = !_played;
    // 使用定时器隐藏stateView
    [self useTimerToHiddenStateView];
}


#pragma mark --- sendVideonPlayURLAction
- (void)sendVideonPlayURL:(NSNotification *)noti {
    self.numberCount++;
    if (self.numberCount == 1) {

        [self.dancePlayer replaceCurrentItemWithPlayerItem:nil];
        //    self.playerItem = nil;
        
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        
        [self.dancePlayer pause];
        self.stateButton.hidden = YES;
        self.movieImage.image = nil;
//        [self.playerItem release];
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:noti.userInfo[@"key"]]];
        
        [self.dancePlayer replaceCurrentItemWithPlayerItem:self.playerItem];
        
        
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
        
        [self.dancePlayer play];
        movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
        [stateView.stateBtn setImage:[UIImage imageNamed:@"Player_暂停@2x"] forState:UIControlStateNormal];
        _played = !_played;
    }
}


// 全屏按钮点击事件
- (void)screenStateBtnAction:(UIButton *)btn {
    if (!_screenBtn) {
        [btn setBackgroundImage:[UIImage imageNamed:@"adSmallScreen"] forState:UIControlStateNormal];
        self.navigationController.navigationBarHidden = YES;
        self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
        
        self.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, kScreenWidth);
        self.movieImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, kScreenWidth);
        
        movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
        stateView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height - kScreenWidth) / 2, kScreenWidth - 4 * kBaseScale - kMargin / 2, kScreenWidth, 4 * kBaseScale);
        self.stateButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height - 5 * kBaseScale) / 2, (kScreenWidth - 5 * kBaseScale) / 2, 5 * kBaseScale, 5 * kBaseScale);
        ((DanceViewController *)self.childViewControllers.lastObject).view.hidden = YES;
        
        
    } else {
        
        [btn setBackgroundImage:[UIImage imageNamed:@"adFullScreen"] forState:UIControlStateNormal];
        self.navigationController.navigationBarHidden = NO;
        self.view.transform = CGAffineTransformMakeRotation(M_PI*0);
        
        self.layer.frame = CGRectMake(0, 0, kScreenWidth, 18 * kBaseScale);
        self.movieImage.frame = CGRectMake(0, 0, kScreenWidth, 18 * kBaseScale);
        movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
        stateView.frame = CGRectMake(0, 14 * kBaseScale - kMargin / 2, kScreenWidth, 4 * kBaseScale);
        ((DanceViewController *)self.childViewControllers.lastObject).view.hidden = NO;
        self.stateButton.frame = CGRectMake(13.5 * kBaseScale, 6.5 * kBaseScale, 5 * kBaseScale, 5 * kBaseScale);
        
    }
    _screenBtn = !_screenBtn;
    
}


// 定时器触发事件
- (void)timerAction {
    movieStateView *stateView = (movieStateView *)[self.view viewWithTag:300];
    stateView.hidden = YES;
}



#pragma mark -- contentView

// 判断数据来源 根据数据来源 添加 内容页
- (void)judgeDataSource {
    //    NSLog(@"%ld", self.viewTag);
    if (self.viewTag == 0) {
        
        // 添加内容页
        [self addContentView];
        // 添加推荐页面详情
        [self addSubView:self.movieStr];
        
    } else if (101 <= self.viewTag && self.viewTag <= 120){
        
        // 数据解析 并添加分类页面详情
        [self getMoviePath:self.listModel.listID];
        
    }else  {
        // if (200 <=self.viewTag && self.viewTag <= 204)
        // 数据解析并添加 五个button 二级界面cell的详情内容
        [self getFiveButtonCellDetail:self.detailID];
        [self getCommentDataWithURLID:self.detailID];
    }
}

- (void)addWuBaListDetainContentView:(NSString *)str {
    WubaListDetailViewController *detailVC = [[WubaListDetailViewController alloc] init];
    
    detailVC.tableView.frame = CGRectMake(0, 18 * kBaseScale + kMargin, kScreenWidth, kScreenHeight - 18 * kBaseScale - kMargin - 64);
    detailVC.listModel = self.listModel;
    //    detailVC.strID = str;
    [detailVC sendFromBeforeVCURLID:str];
    [self addChildViewController:detailVC];
    [self.view addSubview:detailVC.tableView];
    [detailVC release];
}

// 添加推荐 内容页
- (void)addContentView {
    
    DanceViewController *danceVC = [[DanceViewController alloc] init];
    [danceVC configureCellWithModel:self.model];
    [self addChildViewController:danceVC];
    [self.view addSubview:danceVC.view];
    [danceVC release];
    
}

// 添加五个button的内容播放详情页
- (void)addFiveBtnPlayContentView {
    HH_AllViewController *hhAllVC = [[HH_AllViewController alloc] init];
    hhAllVC.view.frame = CGRectMake(0, 18 * kBaseScale + kMargin, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 18 * kBaseScale - kMargin);
    
    //    hhAllVC.otherVideoVC.delegate = self;
    HH_OtherViedeoTableVC *videoTableVC = [[[HH_OtherViedeoTableVC alloc] init] autorelease];
    videoTableVC.delegate = self;
    
    
    //课堂界面cell
    NSMutableArray *videoNameArr = [@[] mutableCopy];
    NSMutableArray *videoPathArr = [@[] mutableCopy];
    [self.videoSourse enumerateObjectsUsingBlock:^(HBCVideoModel* obj, NSUInteger idx, BOOL * stop) {
        [videoNameArr addObject:obj.title];
        [videoPathArr addObject:obj.path];
    }];
    hhAllVC.videoPath = videoPathArr;
    hhAllVC.nameArr = videoNameArr;
    
    //课堂界面标头
    hhAllVC.otherVideoVC.headerView.titleLabel.text = self.hbcDetail.title;
    hhAllVC.otherVideoVC.titleText = self.hbcDetail.title;
    hhAllVC.otherVideoVC.headerView.introduceTextView.text = self.hbcDetail.content;
    [hhAllVC.otherVideoVC.headerView.autoIconImageView JF_setImageWithURL:self.hbcDetail.face placeHolderImage:@"default_indexpic_2x.png"];
    hhAllVC.otherVideoVC.headerView.autoName.text = self.hbcDetail.nicheng;
    
    
    //评论界面标头
    [self.likePerIconSourse enumerateObjectsUsingBlock:^(HBCLikePerModel * obj, NSUInteger idx, BOOL * stop) {
        
        UIImageView *image = [[[UIImageView alloc] initWithFrame:CGRectMake(5*kOneWidth5s+35*kOneWidth5s*idx, 5*kOneHeight5s, 30*kOneWidth5s, 30*kOneHeight5s)] autorelease];
        image.layer.cornerRadius = 15*kOneWidth5s;
        image.layer.masksToBounds = YES;
        [image JF_setImageWithURL:obj.face placeHolderImage:@"default_indexpic_2x.png"];
        
        if ([obj.face isEqualToString:@""]) {
            image.backgroundColor = [UIColor redColor];
        }
        [hhAllVC.commentVC.headerView addSubview:image];
        
        if (idx == 8) {
            *stop = YES;
        }
    }];
    
    //评论界面内容 //username 要放在最后一个赋值
    hhAllVC.commentVC.dataSource = self.commentSource;
    hhAllVC.commentVC.headerView.likeCountLabel.text = self.hbcDetail.like_count;
    [self addChildViewController:hhAllVC];
    [self.view addSubview:hhAllVC.view];
    [hhAllVC release];
    
}



#pragma mark ---- NetRequestDataAndAnalysisData

// 分类详情 网络数据请求解析
- (void)getMoviePath:(NSString *)str {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://client-api.dingdone.com/97AX8NW8A6/content/%@", str];
    NetWorkManager *net = [[NetWorkManager alloc] init] ;
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        // 封装
        TrainDetailModel *model = [[[TrainDetailModel alloc] initWithDictionary:object[@"data"][@"video"]] autorelease];
        
        NSString *videoStr = [NSString stringWithFormat:@"%@/%@", model.host, model.filepath];
        // 解析完数据添加相关控件
        [self addSubView:videoStr];
        [self addWuBaListDetainContentView:str];
        
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);  // 解析失败
    }];
    [net release];
}

// 五个button 内tableViewCell 的详情 网络数据请求解析

- (void)getFiveButtonCellDetail:(NSString *)mID {
    self.videoSourse = [@[] mutableCopy];
    self.likePerIconSourse = [@[] mutableCopy];
    NSString *urlStr = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&id=%@&openid=040502418AAFE2976D2D683E8DAB750F&apptoken=fca532e266489d84aec05924164ac854&m=rows&c=school", mID];
    NetWorkManager *net = [[[NetWorkManager alloc] init] autorelease];
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        // 获取详情内容数据
        self.hbcDetail = [HBCDetailModel detailModelWithDictionary:object[@"data"][@"teach"]];

        // 获取视频数据
        for (NSDictionary *tempDic in object[@"data"][@"video"]) {
            HBCVideoModel *videoModel = [HBCVideoModel videoModelWithDictionary:tempDic];
            [self.videoSourse addObject:videoModel];
        }
        
        // 解析完成添加相应空间
        [self addSubView:((HBCVideoModel *)[self.videoSourse firstObject]).path];
        
        // 遍历 获取喜欢人头像数据
        for (NSDictionary *likeDic in object[@"data"][@"like"]) {
            HBCLikePerModel *likeModel = [HBCLikePerModel likePerModelWithDictionary:likeDic];
            [self.likePerIconSourse addObject:likeModel];
        }
        [(UITableView *)[self.view viewWithTag:500] reloadData];
        
        // 添加五个button的内容播放详情页
        [self addFiveBtnPlayContentView];
        
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}



// 评论数据解析
- (void)getCommentDataWithURLID:(NSString *)URLID {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://interface.tiaooo.com/?&version=2.6.3&id=%@&openid=040502418AAFE2976D2D683E8DAB750F&apptoken=fca532e266489d84aec05924164ac854&m=get_comment&page=1&c=school", URLID];
    
    self.commentSource = [@[] mutableCopy];
    NetWorkManager *net = [[[NetWorkManager alloc] init]autorelease];
    [net getDataWithURLString:urlStr success:^(NetWorkManager *net, id object) {
        for (NSDictionary *tempDic in object[@"data"]) {
            HBCComment *model = [HBCComment commentModelWithDictionary:tempDic];
            [self.commentSource addObject:model];
        }
    } fialBlock:^(NetWorkManager *net, NSError *error) {
        NSLog(@"%@", error);
        
    }];
    
}


- (void)dealloc
{
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.dancePlayer removeTimeObserver:self.playbackTimeObserver];
    
    self.commentSource = nil;
    self.HeaderBtnCellImageViewName = nil;
    self.HiTimer = nil;
    self.layer = nil;
    self.playbackTimeObserver = nil;
    self.model = nil;
    self.movieImage = nil;
    self.movieStr = nil;
    self.stateButton = nil;
    self.playerItem = nil;
    self.dancePlayer = nil;
    self.detailID = nil;
    self.listModel = nil;
    self.videoSourse = nil;
    self.likePerIconSourse = nil;
    [_totalTime release];
    _totalTime = nil;
    _dateFormatter = nil;
    
    [super dealloc];
}

/*
{
////该方法为视图的方法, 当旋转时, 视图会自动调用该方法, 用来重新布局子视图
//- (void)layoutSubviews {
//    [self.view layoutSubviews];
//    // 1.获取当前屏幕所处的状态(旋转方向)
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    // 2.判断屏幕的方向, 调整子视图.
//    switch (orientation) {
//        case UIInterfaceOrientationPortrait:
//            //NSLog(@"竖屏");
//            // break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//            //NSLog(@"倒置");
//           self.layer.frame = CGRectMake(0, 0, kScreenWidth, kBaseScale * 18);
//
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//            //NSLog(@"左横屏");
//            // break;
//        case UIInterfaceOrientationLandscapeRight:
//             self.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, kScreenWidth);
//            //NSLog(@"右横屏");
//            break;
//        default:
//            break;
//    }
//
//}
}
 */



@end
