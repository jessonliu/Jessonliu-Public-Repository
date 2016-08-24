//
//  HH_AllViewController.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HH_HeaderView.h"
#import "HH_OtherViedeoTableVC.h"
#import "HH_CommentTableVC.h"

@interface HH_AllViewController : UIViewController

//上面有一个view -> 两个button 两个对应的红色小View(具有动画效果)
@property (nonatomic, strong)HH_HeaderView *headerView;   

//下面有一个scrollview -> 两个tableView 视图控制器
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)HH_OtherViedeoTableVC *otherVideoVC;
@property (nonatomic, strong)HH_CommentTableVC *commentVC;


//课堂的值
@property (nonatomic, retain)NSMutableArray *nameArr;
@property (nonatomic, retain)NSMutableArray *videoPath;

//评论的值
@property (nonatomic, retain)NSMutableArray *userIcon;//存放用户头像的数组
@property (nonatomic, retain)NSMutableArray *userName;//存放用户昵称的数组  string
@property (nonatomic, retain)NSMutableArray *userComment;//存放用户评论的内容  string




@end
