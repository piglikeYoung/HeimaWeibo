//
//  JHTabBarViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHHomeViewController.h"
#import "JHMessageViewController.h"
#import "JHDiscoverViewController.h"
#import "JHProfileViewController.h"
#import "JHNavigationController.h"

@interface JHTabBarViewController ()

@end

@implementation JHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    JHHomeViewController *home = [[JHHomeViewController alloc] init];
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    JHMessageViewController *message = [[JHMessageViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    JHDiscoverViewController *discover = [[JHDiscoverViewController alloc] init];
    [self addOneChlildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    JHProfileViewController *profile = [[JHProfileViewController alloc] init];
    [self addOneChlildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    

    // 设置标题
    // 相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    //    childVc.tabBarItem.title = title; // tabbar标签上
    //    childVc.navigationItem.title  = title; // 导航栏
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    
    // 在iOS7中, 会对selectedImage的图片进行再次渲染为蓝色
    // 要想显示原图, 就必须得告诉它: 不要渲染
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}



@end
