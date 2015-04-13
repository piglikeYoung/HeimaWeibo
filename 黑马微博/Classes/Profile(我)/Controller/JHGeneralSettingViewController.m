//
//  JHGeneralSettingViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHGeneralSettingViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonItem.h"
#import "JHCommonArrowItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonLabelItem.h"

@interface JHGeneralSettingViewController ()

@end

@implementation JHGeneralSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
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
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonLabelItem *readMdoe = [JHCommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.text = @"有图模式";
    
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    
}

- (void)setupGroup2
{
    
}

@end
