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

@interface JHDiscoverViewController ()

@property (strong , nonatomic) NSMutableArray *groups;

@end

@implementation JHDiscoverViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    
    return _groups;
}

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 搜索框
    JHSearchBar *searchBar = [JHSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    // 初始化模型数据
    [self setupGroups];
    
    // 设置tableView属性
    self.tableView.backgroundColor = JHGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = JHStatusCellInset;
    self.tableView.contentInset = UIEdgeInsetsMake(JHStatusCellInset - 35, 0, 0, 0);
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
    JHCommonSwitchItem *music = [JHCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
    JHCommonItem *movie = [JHCommonItem itemWithTitle:@"电影" icon:@"movie"];
    JHCommonLabelItem *cast = [JHCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.badgeValue = @"500";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    JHCommonArrowItem *more = [JHCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
}


#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCommonCell *cell = [JHCommonCell cellWithTableView:tableView];
    JHCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

@end
