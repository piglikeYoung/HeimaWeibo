//
//  JHStatusDetailViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusDetailViewController.h"
#import "JHStatusDetailView.h"
#import "JHStatusDetailFrame.h"
#import "JHStatus.h"
#import "JHStatusDetailBottomToolbar.h"

@interface JHStatusDetailViewController ()
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) JHStatusDetailBottomToolbar *toolbar;
@end

@implementation JHStatusDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    
    // 创建tableView
    [self setupTableView];
    
    // 创建微博详情控件
    [self setupDetailView];
    
    // 创建底部工具条
    [self setupToolbar];
    
    
}

/**
 *  创建底部工具条
 */
- (void)setupToolbar
{
    JHStatusDetailBottomToolbar *toolbar = [[JHStatusDetailBottomToolbar alloc] init];
    toolbar.y = CGRectGetMaxY(self.tableView.frame);
    toolbar.width = self.view.width;
    toolbar.height = self.view.height - self.tableView.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;

}


/**
 *  创建微博详情控件
 */
- (void)setupDetailView
{
    // 创建微博详情控件
    JHStatusDetailView *detailView = [[JHStatusDetailView alloc] init];
    // 创建frame对象
    JHStatusDetailFrame *detailFrame = [[JHStatusDetailFrame alloc] init];
    // 转发微博内容下面要显示工具条
    self.status.retweeted_status.detail = YES;
    detailFrame.status = self.status;
    
    // 传递frame数据
    detailView.detailFrame = detailFrame;
    // 设置微博详情的高度
    detailView.height = detailFrame.frame.size.height;
    self.tableView.tableHeaderView = detailView;
}


/**
 *  创建tableView
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.width = self.view.width;
    tableView.height = self.view.height - 35;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = JHGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}





@end
