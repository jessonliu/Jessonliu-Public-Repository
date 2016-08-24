//
//  DanceListModel.h
//  DancingDemol
//
//  Created by laouhn on 15/10/8.
//  Copyright © 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanceListModel : NSObject


@property (nonatomic, copy)NSString *listID;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *thumb;
@property (nonatomic, copy)NSString *hits;
@property (nonatomic, copy)NSString *content;



/*
"id": "36",
"title": "Lily老师教你跳肚皮舞",
"thumb": "http://7u2ovi.com2.z0.glb.qiniucdn.com/FsGRvntoxJQTkOGB93zqFcyv7ZSc",
"hits": "4362",
"content": "神秘，性感又养生的肚皮舞<h>Lily老师教你跳出美丽跳出健康~"
 */
 
@end
