//
//  AVPlerViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface AVPlerViewController : UIViewController

// 使用需要导入AVFoundation.framework 框架


// 视频播放链接
- (void)JF_VideoPlayWithURLString:(NSString *)URLStr;
// 视频的布局
- (void)JF_VideoPlayerWithFrame:(CGRect)frame;
// 视频显示图片
- (void)JF_VideoPlayShowImageWithImageName:(NSString *)imageName;
// 返回上一界面 停止视频播放
- (void)JF_VideoPlayBackAndStopVideoPlay;





@end

