//
//  JHHomeViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHTitleButton.h"

@interface JHHomeViewController ()

@property (assign , nonatomic) BOOL down;

@end

@implementation JHHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    
    // 设置导航栏中间的标题按钮
    JHTitleButton *titleButton = [[JHTitleButton alloc] init];
    // 设置文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    
    
    // 设置图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置尺寸
    titleButton.width = 100;
    titleButton.height = 35;
    
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];

    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}


/**
 *  第一种方案，提供成员变量作为判断条件
 
- (void)titleClick:(UIButton *)titleButton
{
    if (self.down) {
        self.down = NO;
        // 换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    } else {
        self.down = YES;
        // 换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}
 */

/**
 * 第二种方案，使用tag的方式，但这种方式不好，别人不知道tag的意思
 
- (void)titleClick:(UIButton *)titleButton
{
    if (titleButton.tag == 0) {
        titleButton.tag = 10;
        // 换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    } else{
        titleButton.tag = 0;
        // 换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}
 */

/**
 * 第三种方案，获取当前图片来判断，推荐使用这种
 */
- (void)titleClick:(UIButton *)titleButton
{
    UIImage *downImage = [UIImage imageWithName:@"navigationbar_arrow_down"];
    if (titleButton.currentImage == downImage) {
        // 换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    } else{
        // 换成箭头向上
        [titleButton setImage:downImage forState:UIControlStateNormal];
    }
}
 

@end
