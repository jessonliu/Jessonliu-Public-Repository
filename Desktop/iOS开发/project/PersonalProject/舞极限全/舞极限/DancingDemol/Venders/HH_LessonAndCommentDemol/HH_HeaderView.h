//
//  HH_HeaderView.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroValue.h"

@interface HH_HeaderView : UIView

//上面有两个button
@property (nonatomic, strong)UIButton *videoBtn;
@property (nonatomic, strong)UIButton *commentBtn;
//下面有一个和button位置对应的小滑块
@property (nonatomic, strong)UIView *sliderView;

@end
