//
//  WubaListDetailViewController.h
//  DancingDemol
//
//  Created by laouhn on 15/10/13.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainListModel.h"

@interface WubaListDetailViewController : UITableViewController

@property (nonatomic, retain) TrainListModel *listModel;
@property (nonatomic, retain) NSString *strID;

- (void)sendFromBeforeVCURLID:(NSString *)strID;

@end
