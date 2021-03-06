//
//  AppDelegate.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "AppDelegate.h"
#import "JHOAuthViewController.h"
#import "JHControllerTool.h"
#import "JHAccountTool.h"
#import "JHAccount.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "MBProgressHUD+MJ.h"
#import "JHHttpTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.显示窗口(需要放在设置根控制器的上面，因为chooseRootViewController方法要获取keyWindow，不先设置keyWindow，UIWindow *window = [UIApplication sharedApplication].keyWindow;获取为nil)
    [self.window makeKeyAndVisible];
    
    // 3.设置窗口的根控制器
    JHAccount *account = [JHAccountTool account];
    if (account) {
        [JHControllerTool chooseRootViewController];
        
    } else { // 没有登录过
        self.window.rootViewController = [[JHOAuthViewController alloc] init];
    }
    
    // 4.监控网络
    [JHHttpTool startMonitoring];
    
    return YES;
}

/**
 *  程序进入后台的时候调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间是不确定）
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台运行的时间到期了，就会自动调用这个block
        [application endBackgroundTask:taskID];
    }];
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
