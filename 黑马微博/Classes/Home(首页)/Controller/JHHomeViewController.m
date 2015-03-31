//
//  JHHomeViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHTitleButton.h"
#import "JHPopMenu.h"

@interface JHHomeViewController ()<JHPopMenuDelegate>

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
 * 点击显示弹出框
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 换成箭头向上
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    JHPopMenu *menu = [[JHPopMenu alloc] initWithContentView:button];
    menu.delegate = self;
    // 设置弹出框突起的位置
    menu.arrowPosition = JHPopMenuArrowPositionCenter;
    // 是否开启遮罩效果
    menu.dimBackground = YES;
    [menu showInRect:CGRectMake(100, 100, 100, 100)];
}

#pragma mark - 弹出菜单协议
- (void)popMenuDidDismissed:(JHPopMenu *)popMenu{
    JHTitleButton *titleButton = (JHTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


- (void)pop
{
    JHLog(@"pop---");
}

- (void)friendSearch
{
    JHLog(@"friendSearch---");
    
}

@end
