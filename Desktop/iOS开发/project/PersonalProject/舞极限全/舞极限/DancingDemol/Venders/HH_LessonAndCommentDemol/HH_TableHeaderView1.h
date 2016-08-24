//
//  HH_TableHeaderView1.h
//  Dancing_TableView
//
//  Created by laouhn on 15/10/9.
//  Copyright © 2015年 张豪豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroValue.h"

@interface HH_TableHeaderView1 : UIView

//上面有一个titleLabel 一个简介TextView 一个作者头像ImageView  一个作者名字Label

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UITextView *introduceTextView;
@property (nonatomic, strong)UIImageView *autoIconImageView;
@property (nonatomic, strong)UILabel *autoName;

@end
