//
//  JHSettingViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHSettingViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonItem.h"
#import "JHCommonArrowItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonLabelItem.h"
#import "JHGeneralSettingViewController.h"

@interface JHSettingViewController ()

@end

@implementation JHSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroups];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:JHColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.footer = @"tail部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *newFriend = [JHCommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *newFriend = [JHCommonArrowItem itemWithTitle:@"主题、背景"];
    
    group.items = @[newFriend];
}

- (void)setupGroup2
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"头部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *generalSetting = [JHCommonArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [JHGeneralSettingViewController class];
    
    group.items = @[generalSetting];
}

@end
