//
//  AppDelegate.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "AppDelegate.h"
#import "JHTabBarViewController.h"
#import "JHNewfeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置状态栏不隐藏
    application.statusBarHidden = NO;
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
//    // 2.设置窗口的根控制器
//    // 如何知道第一次使用这个版本？比较上次的使用情况
//    NSString *versionKey = @"CFBundleVersion";
////    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;// 也可以获取软件版本
//    
//    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion = [defaults objectForKey:versionKey];
//    
//    // 获得当前打开软件的版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//    
//    if ([currentVersion isEqualToString:lastVersion]) {
//        // 当前版本号 == 上次使用的版本：显示JHTabBarViewController
//        self.window.rootViewController = [[JHTabBarViewController alloc] init];
//    } else {
        // 当前版本号 != 上次使用的版本：显示版本新特性
        self.window.rootViewController = [[JHNewfeatureViewController alloc] init];
        
//        // 存储这次使用的软件版本
//        [defaults setObject:currentVersion forKey:versionKey];
//        [defaults synchronize];
//    }
    
    
    // 3.显示窗口
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

@end
