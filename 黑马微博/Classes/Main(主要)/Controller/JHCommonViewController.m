//
//  JHCommonViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHCommonViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonItem.h"
#import "JHCommonCell.h"
#import "JHCommonArrowItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonLabelItem.h"


/**
 用一个模型来描述每组的信息：组头、组尾、这组的所有行模型
 用一个模型来描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）
 */


@interface JHCommonViewController ()
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation JHCommonViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = JHGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = JHStatusCellInset;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(JHStatusCellInset - 35, 0, 0, 0);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.header;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    JHCommonGroup *group = self.groups[indexPath.section];
    JHCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}


@end
