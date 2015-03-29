//
//  JHNavigationController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/29.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  能拦截所有push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有第一次push的控制器显示bottomBar，别的都隐藏
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
