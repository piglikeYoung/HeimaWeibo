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

@interface JHStatusDetailViewController ()

@end

@implementation JHStatusDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    
//    // 创建tableView
//    [self setupTableView];
//    
//    // 创建微博详情控件
//    [self setupDetailView];
//    
//    // 创建底部工具条
//    [self setupToolbar];
    
    self.tableView.backgroundColor = JHGlobalBg;
    
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
 *  创建底部工具条
 */
- (void)setupToolbar
{
    
}

@end
