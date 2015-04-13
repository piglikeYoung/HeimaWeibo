//
//  JHProfileViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHProfileViewController.h"
#import "JHDiscoverViewController.h"
#import "JHSearchBar.h"
#import "JHCommonGroup.h"
#import "JHCommonItem.h"
#import "JHCommonCell.h"
#import "JHCommonArrowItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonLabelItem.h"
#import "JHSettingViewController.h"

@implementation JHProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // 初始化模型数据
    [self setupGroups];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting
{
    JHSettingViewController *setting = [[JHSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)setupGroups
{
    //第0组
    [self setupGroup0];
    //第1组
    [self setupGroup1];
}

-(void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *newFriend = [JHCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *album = [JHCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    JHCommonArrowItem *collect = [JHCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"1";
    
    JHCommonArrowItem *like = [JHCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.badgeValue = @"10";
    
    group.items = @[album, collect, like];
}


@end