//
//  TrainListController.h
//  DancingDemol
//
//  Created by laouhn on 15/9/24.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TrainListController : UITableViewController

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSString *titID;


- (void)getTitleID:(NSString *)titID;

@end
