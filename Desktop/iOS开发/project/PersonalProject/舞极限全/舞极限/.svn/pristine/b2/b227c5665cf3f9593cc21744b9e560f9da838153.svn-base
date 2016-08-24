//
//  WeatherManager.m
//  DancingDemol
//
//  Created by laouhn on 15/10/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager



+ (void)getWeatherModelSuccess:(getSuccessBlock)sucess fail:(getFailBlock)fail {
    //获取当前城市
    WeatherManager *manager = [[[WeatherManager alloc] init] autorelease];
    manager.model = [[WeatherModel new] autorelease];
    [manager.model getPlacemarkSucess:^(WeatherModel *model, CLPlacemark *obj) {
        manager.cityName = obj.addressDictionary[@"City"];
        {
            //拼接url连接
            NSString *URLStr = [NSString stringWithFormat:@"http://weather.dingdone.com/weather.php?a=show&name=%@&appid=4&appkey=zKjBvH9Mz2GgxAkYOP5wcKLUTZB82CMs", [manager.cityName substringToIndex:manager.cityName.length - 1]];
            URLStr = [URLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //创建连接, 并解析
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                id arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//这个数组包含最近一周的当地天气信息
                
                        if (arr) {
                            sucess(manager, arr);
                        } else {
                            fail(manager, connectionError);
                        }
                
            }];

        }
        
    } faild:^(WeatherModel *model, NSError *error) {
        
    }];
    
    
    
}


- (void)dealloc
{
    self.cityName = nil;
    self.model = nil;
    [super dealloc];
}



@end
