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
#import "JHTabBar.h"
#import "JHComposeViewController.h"
#import "JHUserTool.h"
#import "JHAccountTool.h"
#import "JHAccount.h"

@interface JHTabBarViewController ()<JHTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) JHHomeViewController *home;
@property (nonatomic, weak) JHMessageViewController *message;
@property (nonatomic, weak) JHProfileViewController *profile;
@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;

@end

@implementation JHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
    
    // 利用定时器获得用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)getUnreadCount
{
    // 1.请求参数
    JHUnreadCountParam *param = [JHUnreadCountParam param];
    param.uid = [JHAccountTool account].uid;
    
    // 2.获取未读数
    [JHUserTool unreadCountWithParam:param success:^(JHUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 判断是否系统是否大于iOS8，iOS8之后需要申请权限才能显示applicationIconBadgeNumber
        if (iOS8) {
            UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else
        {
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        }
        
        // 在图标上显示所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
//        JHLog(@"总未读数--%d", result.totalCount);
    } failure:^(NSError *error) {
        JHLog(@"获得未读数失败---%@", error);
    }];
}


/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 调整TabBar
    JHTabBar *customTabBar = [[JHTabBar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}


/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    // 添加子控制器
    JHHomeViewController *home = [[JHHomeViewController alloc] init];
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewContoller = home;
    
    JHMessageViewController *message = [[JHMessageViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    JHDiscoverViewController *discover = [[JHDiscoverViewController alloc] init];
    [self addOneChlildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    JHProfileViewController *profile = [[JHProfileViewController alloc] init];
    [self addOneChlildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}

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

    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
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

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    // 拿到栈顶的控制器，即点击了TabBar的哪个控制器
    UIViewController *vc = [viewController.viewControllers firstObject];
    
    // 如果是首页控制器
    if ([vc isKindOfClass:[JHHomeViewController class]]) {
        // 最后选中的控制器等于当前控制器才回到顶端，否则点击别的控制器，再回来不回到顶端
        if (self.lastSelectedViewContoller == vc) {
            [self.home refresh:YES];
        } else {
            [self.home refresh:NO];
        }
    }
    
    self.lastSelectedViewContoller = vc;
}


#pragma mark - JHTabBarDelegate
- (void)tabBarDidClickedPlusButton:(JHTabBar *)tabBar
{
    // 弹出发微博控制器
    JHComposeViewController *compose = [[JHComposeViewController alloc] init];
    JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:compose];
    
    
    
    [self presentViewController:nav animated:YES completion:nil];
    
}



@end
