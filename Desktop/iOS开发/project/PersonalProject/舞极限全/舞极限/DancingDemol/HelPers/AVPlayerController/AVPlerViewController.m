//
//  AVPlerViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import "AVPlerViewController.h"
#import "AVPlayerSingleTon.h"
#import "AVPlayerTumberView.h"
#import "AVPlayerStateView.h"

#import "BasicNVC.h"
#import "TrainDetailCellDefine.h"
#import "UIImageView+Cache.h"



@interface AVPlerViewController () {
    BOOL _played;
    BOOL _touch;
    BOOL _screenBtn;
    NSString *_totalTime;
    NSDateFormatter *_dateFormatter;
}

@property (nonatomic, retain) AVPlayer *dancePlayer;     // 视频播放器
@property (nonatomic, retain) AVPlayerLayer *layer;      // 视频放置
@property (nonatomic, retain) UIButton *stateButton;    // 视频中心按钮
@property (nonatomic, retain) id playbackTimeObserver;  //
@property (nonatomic, retain) NSTimer *HiTimer;         // 定时器

@property (nonatomic, retain) UIImageView *movieImage; // 视频上边的图片
@property (nonatomic, assign) CGFloat currentProgress; // 当前进度条
@property (nonatomic, assign) CGFloat cachesProgress;  // 缓存进度条
@property (nonatomic, retain) NSString *videoURLStr; // 视频播放链接
@property (nonatomic, retain) AVPlayerItem *playerItem;  // 视频Item

@end

@implementation AVPlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 添加视频控件
    [self addDancePlayer:self.videoURLStr];
    //    [self addPlayerBarGBImage];
    // 添加视频显示图
    [self addMovieView];
    // 添加player 上的button
    [self.view addSubview:self.stateButton];
    // 添加视频状态条
    [self addMovieStateBar];
}

// 视频中心按钮
- (UIButton *)stateButton {
    if (!_stateButton) {
        self.stateButton = [[[UIButton alloc] initWithFrame:CGRectMake(13.5 * CGRectGetMaxX(self.layer.frame) / 32 , 6.5 * CGRectGetMaxX(self.layer.frame) / 32, 5 * CGRectGetMaxX(self.layer.frame) / 32, 5 * CGRectGetMaxX(self.layer.frame) / 32)] autorelease];
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
    
    AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
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


- (void)addPlayerBarGBImage {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 20 * kBaseScale, kScreenWidth - 2 * kMargin, 1)] autorelease];
    imageView.alpha = 0.4;
    imageView.image = [UIImage imageNamed:@"picflow_title_bg@2x副本"];
    [self.view addSubview:imageView];
}


// 添加视频显示图片
- (void)addMovieView {
    self.movieImage = [[[UIImageView alloc] initWithFrame:self.layer.frame] autorelease];
    self.movieImage.userInteractionEnabled = YES;
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
    AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
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
   
}


// 视频控件设置
- (void)addDancePlayer:(NSString *)movieStr {
    NSURL *movieURL = [NSURL URLWithString:movieStr];
    self.playerItem = [AVPlayerItem playerItemWithURL:movieURL];
    self.dancePlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.dancePlayer];
    //self.layer.transform = CATransform3D
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    self.layer.frame = CGRectMake(0, 0, kScreenWidth, kBaseScale * 18);
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:self.layer];
}


// 添加视频状态条
- (void)addMovieStateBar {
    AVPlayerStateView *stateView = [[[AVPlayerStateView alloc] init] autorelease];
    stateView.frame = CGRectMake(0, 14 * CGRectGetMaxX(self.layer.frame) / 32, kScreenWidth, 4 * CGRectGetMaxX(self.layer.frame) / 32);
    stateView.hidden = YES;
    stateView.tag = 300;
    
    [stateView.screenStateBtn addTarget:self action:@selector(screenStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [stateView.stateBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stateView];
}

// 全屏按钮点击事件
- (void)screenStateBtnAction:(UIButton *)btn {
    if (!_screenBtn) {
        self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
        self.navigationController.navigationBarHidden = YES;
        self.layer.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.height - 20, kScreenWidth);
        self.movieImage.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.height - 20, kScreenWidth);
        AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
        stateView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height - 20 - kScreenWidth) / 2, kScreenWidth - 4 * kBaseScale, kScreenWidth, 4 * kBaseScale);
        self.stateButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height - 20 - 5 * kBaseScale) / 2, (kScreenWidth - 5 * kBaseScale) / 2, 5 * kBaseScale, 5 * kBaseScale);
    } else {
        self.view.transform = CGAffineTransformMakeRotation(M_PI*0);
        self.navigationController.navigationBarHidden = NO;
        self.layer.frame = CGRectMake(0, 0, kScreenWidth, 18 * kBaseScale);
        self.movieImage.frame = CGRectMake(0, 0, kScreenWidth, 18 * kBaseScale);
        AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
        stateView.frame = CGRectMake(0, 14 * kBaseScale, kScreenWidth, 4 * kBaseScale);
        self.stateButton.frame = CGRectMake(13.5 * kBaseScale, 6.5 * kBaseScale, 5 * kBaseScale, 5 * kBaseScale);
    }
    _screenBtn = !_screenBtn;
    
}


- (void)monitoringPlayback:(AVPlayerItem *)playerItem timgNumer:(CGFloat)timeNumber{
    
    self.playbackTimeObserver = [self.dancePlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [AVPlayerSingleTon sendDataSingleton].currentTime = currentSecond; // 视频当前播放时间 赋给单例
        
        NSString *timeString = [self convertTime:currentSecond];
        // 给timeLabel赋值
        AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
        stateView.timeLable.text = [NSString stringWithFormat:@"%@ / %@", timeString, _totalTime];
        // 滑块的位置.
        stateView.thumbView.frame = CGRectMake((kBaseScale * 3 + 2 * kMargin) + currentSecond * (22 * kBaseScale - kMargin)/timeNumber, 4 + kMargin / 2, 14, 14);
        
        // progressView 的进度
        self.currentProgress = currentSecond / timeNumber;
        [stateView.progressView setProgress:self.currentProgress animated:YES];
        
        
        // 播放到最后一秒 返回开始位置, 并暂停
        [self endPlayeBackBeginAndLetPlayerStop:currentSecond totalTime:timeNumber];
        
    }];
}

// 定时器触发事件
- (void)timerAction {
    AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
    stateView.hidden = YES;
}


// 使用定时器隐藏stateView
- (void)useTimerToHiddenStateView {
    [self.HiTimer invalidate];
    AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
    if (!stateView.hidden) {
        
        // 设置定时器, 三秒隐藏stateView
        self.HiTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil  repeats:YES];
    }
}


// KVO
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary *)change context:(nullable void *)context {
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    [AVPlayerSingleTon sendDataSingleton].temPlayer = self.dancePlayer;  // 视频播放器传给单例
    [AVPlayerSingleTon sendDataSingleton].playState = _played;   // 视频播放器的播放暂停状态转给单例
    
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            //            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            [AVPlayerSingleTon sendDataSingleton].videoSecond = totalSecond;
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            
            AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
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
        AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
        [stateView.cushionView  setProgress:self.cachesProgress animated:YES];
        
        // 检测缓冲条与进度条
        [self monitorProgressView:timeInterval curTime:self.currentProgress * totalDuration];
        
    }
    
}


// 判断缓冲条 与 当前进度条是否相等, 如果不相等, 缓冲条大于进度条, 切处于播放状态 , 让视频自动调用 播放视频;
// cushionTime  缓冲时间
// curTime 当前时间

- (void)monitorProgressView:(CGFloat)cushionTime curTime:(CGFloat)curTime {
    if (_played && (cushionTime > (curTime + 3))) {
        [self.dancePlayer play];
    }
}


// 检测播放, 如果播放完成 返回开始位置, 并暂停播放
- (void)endPlayeBackBeginAndLetPlayerStop:(CGFloat)curTime totalTime:(CGFloat)totalTime{
    if (curTime == (totalTime - 1)) {
        CMTime time = CMTimeMakeWithSeconds(0, self.dancePlayer.currentTime.timescale);
        [self.dancePlayer seekToTime:time];
        [self.dancePlayer pause]; // 让视频暂停播放
        _played = !_played;
        self.stateButton.hidden = NO;  // 视频中心button 显示
        AVPlayerStateView *stateView = (AVPlayerStateView *)[self.view viewWithTag:300];
        [stateView.stateBtn setImage:[UIImage imageNamed:@"跳吧播放详情_开始@2x"] forState:UIControlStateNormal];  // 视频属性条 的button 处于暂停状态
        
    }
}



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

// 缓冲相关方法
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.dancePlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self dancePlayer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self dancePlayer] setPlayer:player];
}



- (void)dealloc
{
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.dancePlayer removeTimeObserver:self.playbackTimeObserver];
    
    self.videoURLStr = nil;
    self.HiTimer = nil;
    self.layer = nil;
    self.playbackTimeObserver = nil;
    self.movieImage = nil;
    self.stateButton = nil;
    self.playerItem = nil;
    self.dancePlayer = nil;
    _totalTime = nil;
    _dateFormatter = nil;
    
    [super dealloc];
}



// 视频播放链接
- (void)JF_VideoPlayWithURLString:(NSString *)URLStr {
    self.videoURLStr = URLStr;
}
// 视频的布局
- (void)JF_VideoPlayerWithFrame:(CGRect)frame {
    self.layer.frame = frame;
}
// 视频显示图片
- (void)JF_VideoPlayShowImageWithImageName:(NSString *)imageName {
    self.movieImage.image = [UIImage imageNamed:imageName];
}
// 返回上一界面 停止视频播放
- (void)JF_VideoPlayBackAndStopVideoPlay {
    [self.dancePlayer replaceCurrentItemWithPlayerItem:nil];
}















@end
