//
//  AppDelegate.m
//  DancingDemol
//
//  Created by laouhn on 15/9/21.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "TrainingViewController.h"
#import "BasicNVC.h"
#import "WelcomeViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    
    
    //用户索引项, 用来存储用户信息, 程序是否是第一次启动,以及保存用户名密码等
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults boolForKey:@"FirstLanch"]) {
        //把标识符存入本地
        [userDefaults setBool:YES forKey:@"FirstLanch"];
        //立即同步
        [userDefaults synchronize];
        
        WelcomeViewController *rootView = [[WelcomeViewController alloc] init];
        self.window.rootViewController = rootView;
        //        [rootView release];
    } else {
        RootViewController *rootVC = [[RootViewController alloc] init];
        BasicNVC *navigationVC = [[BasicNVC alloc] initWithRootViewController:rootVC];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil];
        [rootVC release];
        // 导航条设置图片
        [navigationVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBarBGImage"] forBarMetrics:UIBarMetricsDefault];
        
        sleep(2);
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
        //    默认带有一定透明效果，可以使用以下方法去除系统效果
        [navigationVC.navigationBar setTranslucent:NO];
        
        self.window.rootViewController = navigationVC;
        [navigationVC release];

    }
    
  
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealloc
{
    self.window = nil;
    [super dealloc];
}

@end
