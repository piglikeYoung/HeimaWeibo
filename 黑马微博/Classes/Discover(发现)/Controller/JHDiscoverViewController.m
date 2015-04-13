//
//  JHDiscoverViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHDiscoverViewController.h"
#import "JHSearchBar.h"
#import "JHCommonGroup.h"
#import "JHCommonItem.h"
#import "JHCommonCell.h"
#import "JHCommonLabelItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonArrowItem.h"
#import "HMOneViewController.h"
#import "HMTwoViewController.h"


@implementation JHDiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 搜索框
    JHSearchBar *searchBar = [JHSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
    
    // 初始化模型数据
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
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    JHCommonArrowItem *hotStatus = [JHCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    JHCommonArrowItem *findPeople = [JHCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.badgeValue = @"N";
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonItem *gameCenter = [JHCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    JHCommonLabelItem *near = [JHCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.text = @"测试文字";
    JHCommonItem *app = [JHCommonItem itemWithTitle:@"应用" icon:@"app"];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonSwitchItem *video = [JHCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    video.operation = ^{
        JHLog(@"----点击了视频---");
    };
    JHCommonSwitchItem *music = [JHCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
    music.operation = ^{
        JHLog(@"----点击了音乐---");
    };

    JHCommonItem *movie = [JHCommonItem itemWithTitle:@"电影" icon:@"movie"];
    movie.destVcClass = [HMOneViewController class];
    JHCommonLabelItem *cast = [JHCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.destVcClass = [HMTwoViewController class];
    cast.badgeValue = @"500";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    JHCommonArrowItem *more = [JHCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
}


@end
