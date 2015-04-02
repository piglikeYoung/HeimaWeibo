//
//  HMControllerTool.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "JHControllerTool.h"
#import "JHTabBarViewController.h"
#import "JHNewfeatureViewController.h"


@implementation JHControllerTool

+ (void)chooseRootViewController
{
    // 切换控制器，可能去新特性\tabbar
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 设置状态栏不隐藏
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        // 当前版本号 == 上次使用的版本：显示JHTabBarViewController
        window.rootViewController = [[JHTabBarViewController alloc] init];
    } else {
        // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[JHNewfeatureViewController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}

@end
