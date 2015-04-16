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
#import "MBProgressHUD+MJ.h"
#import "SDImageCache.h"
#import "NSString+File.h"

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
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *clearCache = [JHCommonArrowItem itemWithTitle:@"清除图片缓存"];
    
    NSString *imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    long long fileSize = [imageCachePath fileSize];
    
    clearCache.subtitle = [NSString stringWithFormat:@"(%.1fM)", fileSize / (1000.0 * 1000.0)];
    
    __weak typeof(clearCache) weakClearCache = clearCache;
    __weak typeof(self) weakVc = self;
    clearCache.operation = ^{
        [MBProgressHUD showMessage:@"正在清除缓存...."];
        
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:imageCachePath error:nil];
        
        // 设置subtitle
        weakClearCache.subtitle = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
        
        [MBProgressHUD hideHUD];
        
    };
    
    group.items = @[clearCache];
}

- (void)setupGroup2
{
    
}


- (void)dealloc
{
    JHLog(@"JHGeneralSettingViewController---dealloc");
}

@end
