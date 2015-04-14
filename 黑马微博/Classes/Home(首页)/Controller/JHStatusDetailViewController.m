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

@interface JHStatusDetailViewController ()

@end

@implementation JHStatusDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.tableView.backgroundColor = JHGlobalBg;
    
    // 创建微博详情控件
    JHStatusDetailView *detailView = [[JHStatusDetailView alloc] init];
    // 创建frame对象
    JHStatusDetailFrame *detailFrame = [[JHStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    
    // 传递frame数据
    detailView.detailFrame = detailFrame;
    // 设置微博详情的高度
    detailView.height = detailFrame.frame.size.height;
    self.tableView.tableHeaderView = detailView;
}

@end
