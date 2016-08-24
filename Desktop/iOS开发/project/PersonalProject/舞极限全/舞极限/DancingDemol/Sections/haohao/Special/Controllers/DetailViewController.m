//
//  DetailViewController.m
//  DancingDemol
//
//  Created by laouhn on 15/10/5.
//  Copyright (c) 2015年 JHH. All rights reserved.
//





#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "BasicNVC.h"
#import "MacroValue.h"

#define kWidth [UIScreen mainScreen].bounds.size.width



@interface DetailViewController ()

@property (nonatomic, retain)NSMutableArray *imageArr;
@property (nonatomic, retain)NSString *content;
@property (nonatomic, retain)UIWebView *web;
@end

@implementation DetailViewController


- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        self.imageArr = [NSMutableArray arrayWithCapacity:1];
    }
    return [[_imageArr retain] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定义导航条
    ((BasicNVC *)self.navigationController).titileLabel.text = @"详情";
    
    //定义web视图
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [UIScreen mainScreen].bounds.size.height - 64)];
    self.web.scrollView.showsHorizontalScrollIndicator = NO;
    self.web.scrollView.showsVerticalScrollIndicator = NO;
    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    [lable setBackgroundColor:[UIColor redColor]];
//    [self.web.scrollView addSubview:lable];
    
    [self getDataWithURL:self.detailURL];
    [self.view addSubview:self.web];
    [self.web release];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getDataWithURL:(NSString *)url {
    //开始加载内容, 出现菊花
    [MBProgressHUD showHUDAddedTo:self.web animated:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
        
        
        //处理内容的图片问题
        {
        self.content = dic[@"data"][@"pageContent"];
        [dic[@"data"][@"contentImages"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *temp = [NSString stringWithFormat:@"<div m2o_mark=\"pic_%ld\" style=\"display:none\">", idx];
            NSString *change = [NSString stringWithFormat:@"<img src=%@>", obj[@"host"]];
            self.content = [self.content stringByReplacingOccurrencesOfString:temp withString:change];
        }];
        }
        
        
        //处理用户头像的图片问题
        NSString *picMax = [NSString stringWithFormat:@"width=\"%lf\" height=\"%lf\"", 20*kOneWidth5s, 20*kOneHeight5s];
        self.content = [self.content stringByReplacingOccurrencesOfString:@"<span class=\"user-pic\"><img " withString:[NSString stringWithFormat:@"<span class=\"user-pic\"><img %@", picMax]];

        
        
        
        //进行CSS文件拼接
        NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"css"];
        NSString *cssStr = [NSString stringWithContentsOfFile:cssPath encoding:NSUTF8StringEncoding error:nil];
        NSString *newCSSStr = [NSString stringWithFormat:@"<head><style type=\"text/css\">%@</style></head>", cssStr];
        
        //对CSS文件进行处理
        {
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h1" withString:@"div.atitle"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h2" withString:@"div.news-info"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h3" withString:@"div.time"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h4" withString:@"div.source"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h5" withString:@"div.clicknum"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"h6" withString:@"div.commentnum"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"ul" withString:@"div.info"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"ol" withString:@"div.title"];
            newCSSStr = [newCSSStr stringByReplacingOccurrencesOfString:@"code" withString:@"dic.comment-placehodler"];
        }
        
        self.content = [NSString stringWithFormat:@"%@%@", newCSSStr, self.content];
        
        
        self.content = [self.content stringByReplacingOccurrencesOfString:@"<span class=\"clicknum\">" withString:@"<span class=\"clicknum\"><img src=\"http://a2.qpic.cn/psb?/V10ZVeLu1CIvv4/uc2RLR7Jof6JePDA211lClrITnqUAUzmwT.msbbg4Tw!/m/dGUBAAAAAAAA&ek=1&kp=1&pt=0&bo=KAAoACgAKAADCC0!&sce=0-12-12&rf=0-18\" width=\"20\" height=\"20\">"];
        self.content = [self.content stringByReplacingOccurrencesOfString:@"<span class=\"commentnum\">" withString:@"<span class=\"commentnum\"><img src=\"http://a4.qpic.cn/psb?/V10ZVeLu1CIvv4/z2VhC8LaLFYfnjTnZlSVd3kV2vh2JipZgMIjH8vjnic!/m/dGMBAAAAAAAA&ek=1&kp=1&pt=0&bo=GgAcABoAHAADCC0!&sce=0-12-12&rf=0-18\" width=\"20\" height=\"20\"/>"];
        
        
        
        
        
        //数据获取完毕, 菊花消失
        
        [MBProgressHUD hideHUDForView:self.web animated:YES];
        
        [self.web loadHTMLString:self.content baseURL:nil];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc
{
    self.web = nil;
    self.content = nil;
    self.imageArr = nil;
    self.detailURL = nil;
    [super dealloc];
}

@end
