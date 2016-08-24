//
//  UIRecommendListController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRecommendListController : UITableViewController
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) NSString *titID;
@property (nonatomic,  assign) NSInteger tableViewTagID;

@property (nonatomic, assign) NSInteger start;
@property (nonatomic, retain) NSMutableArray *dataArray;

- (void)getBeforViewURLStr:(NSString *)str;

@end
