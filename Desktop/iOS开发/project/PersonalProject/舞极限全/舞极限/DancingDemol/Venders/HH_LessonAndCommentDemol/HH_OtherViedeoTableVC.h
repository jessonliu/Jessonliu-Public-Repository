//
//  HH_OtherViedeoTableVC.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HH_TableHeaderView1.h"
#import "HH_OtherVideoCell.h"
#import "UIImageView+Cache.h"

//
//@class HH_OtherViedeoTableVC;
//    typedef void (^VideoSuccBlock)(HH_OtherViedeoTableVC *hVC, id object); // 定义成功时的Block 函数


@protocol HH_OtherViedeoTableVCDelegate <NSObject>

- (void)sendVideonPlayURL:(NSString *)videoStr;

@end



@interface HH_OtherViedeoTableVC : UITableViewController

@property (nonatomic, strong)NSString *titleText;//播放视频名字
@property (nonatomic, strong)NSString *introduceText;//简介
@property (nonatomic, strong)NSString *autoIconImageView;//上传者头像
@property (nonatomic, strong)NSString *autoName;//上传者名字


@property (nonatomic, strong)NSMutableArray *videoNameArr;//存放所有视频名字的数组
@property (nonatomic, strong)NSMutableArray *pathArr;//存放所有视频的播放地址的数组
@property (nonatomic, strong)HH_TableHeaderView1 *headerView;

@property (nonatomic, strong) NSString *videoStr;

@property (nonatomic, assign) id<HH_OtherViedeoTableVCDelegate> delegate;

/*
 
 @class NetWorkManager;
 
 typedef void (^SuccessBlock)(NetWorkManager *net, id object); // 定义成功的Block函数
 typedef void (^FialBlock)(NetWorkManager *net, NSError *error); // 定义失败的Block函数
 
 
 @interface NetWorkManager : NSObject
 
 - (void)getDataWithURLString:(NSString *)urlStr success:(SuccessBlock)success fialBlock:(FialBlock)fial;
 
 */
//- (void)sendViewURLStrVideoSuccess:(VideoSuccBlock)videoSuccess;






@end
