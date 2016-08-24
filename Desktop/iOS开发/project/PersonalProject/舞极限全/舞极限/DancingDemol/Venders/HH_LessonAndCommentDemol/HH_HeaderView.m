//
//  HH_HeaderView.m
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import "HH_HeaderView.h"

@implementation HH_HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (UIButton *)videoBtn {
    if(!_videoBtn) {
        self.videoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _videoBtn.frame = CGRectMake(45*kOneWidth5s, 0, 70*kOneWidth5s, 25*kOneHeight5s);
        [_videoBtn setTitle:@"课堂" forState:UIControlStateNormal];
        _videoBtn.tag = 201;
        _videoBtn.tintColor = [UIColor redColor];
        

    }
    return _videoBtn;
}

- (UIButton *)commentBtn {
    if(!_commentBtn) {
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _commentBtn.frame = CGRectMake(195*kOneWidth5s, 0, 70*kOneWidth5s, 25*kOneHeight5s);
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        _commentBtn.tag = 202;
        _commentBtn.tintColor = [UIColor grayColor];

    }
    return _commentBtn;
}
- (UIView *)sliderView {
    if(!_sliderView){
        self.sliderView = [[[UIView alloc] initWithFrame:CGRectMake(45*kOneWidth5s, 25*kOneHeight5s, 70*kOneWidth5s, 5*kOneHeight5s)] autorelease];
        _sliderView.backgroundColor = [UIColor cyanColor];


    }
    return _sliderView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-1, 4*kOneHeight5s, 2*kOneWidth5s, CGRectGetHeight(self.frame)-12)] autorelease];
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.5;
        [self addSubview:view];
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.videoBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.sliderView];
    }
    return self;
}


/*
 //上面有两个button
 @property (nonatomic, strong)UIButton *videoBtn;
 @property (nonatomic, strong)UIButton *commentBtn;
 //下面有一个和button位置对应的小滑块
 @property (nonatomic, strong)UIView *sliderView;
 */


@end
