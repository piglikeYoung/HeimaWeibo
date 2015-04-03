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
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

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
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                JHLog(@"没有网络(断网)");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                JHLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                JHLog(@"WIFI");
            break;}
    }];
    // 开始监控
    [mgr startMonitoring];
    
    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
