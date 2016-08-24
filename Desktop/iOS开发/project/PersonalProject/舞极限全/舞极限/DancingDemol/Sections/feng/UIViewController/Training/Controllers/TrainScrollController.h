//
//  TrainScrollController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TrainScrollControllerDelegate <NSObject>

- (void)senderContentOffSize:(CGFloat)xValue;

@end


@interface TrainScrollController : UIViewController

@property (nonatomic, retain) UIScrollView *trainScrollView; // 列表滚动视图

@property (nonatomic, assign) id <TrainScrollControllerDelegate> delegate;
//@property (nonatomic, retain) NSMutableArray *array;

- (void)getDataArray:(NSMutableArray *)array;

@end
