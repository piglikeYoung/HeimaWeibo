//
//  JHHomeViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHTitleButton.h"
#import "JHPopMenu.h"
#import "AFNetworking.h"
#import "JHAccountTool.h"
#import "JHAccount.h"
#import "UIImageView+WebCache.h"
#import "JHStatus.h"
#import "JHUser.h"

@interface JHHomeViewController ()<JHPopMenuDelegate>

/**
 *  微博数组(存放着所有的微博数据)
 */
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation JHHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏的内容
    [self setupNavBar];
    
    [self loadNewStatus];
}

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatus
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JHAccountTool account].access_token;
    
    // 3.发送GET请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
//        JHLog(@"请求成功--%@", resultDict);
        
        self.statuses = [NSMutableArray array];
        
        // 赋值数组数据
        NSArray *statusDictArray = resultDict[@"statuses"];
        for (NSDictionary *statusDict in statusDictArray) {
            JHStatus *status = [JHStatus statusWithDict:statusDict];
            [self.statuses addObject:status];
        }
        
        // 重新刷新表格
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败--%@", error);
    }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    
    // 设置导航栏中间的标题按钮
    JHTitleButton *titleButton = [[JHTitleButton alloc] init];
    // 设置文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    
    
    // 设置图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置尺寸
    titleButton.width = 100;
    titleButton.height = 35;
    
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}


/**
 * 点击显示弹出框
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 换成箭头向上
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    JHPopMenu *menu = [[JHPopMenu alloc] initWithContentView:button];
    menu.delegate = self;
    // 设置弹出框突起的位置
    menu.arrowPosition = JHPopMenuArrowPositionCenter;
    // 是否开启遮罩效果
    menu.dimBackground = YES;
    [menu showInRect:CGRectMake(100, 100, 100, 100)];
}

#pragma mark - 弹出菜单协议
- (void)popMenuDidDismissed:(JHPopMenu *)popMenu{
    JHTitleButton *titleButton = (JHTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


- (void)pop
{
    JHLog(@"pop---");
}

- (void)friendSearch
{
    JHLog(@"friendSearch---");
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 取出这行对应的微博字典数据
    JHStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 取出用户字典数据
    JHUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 下载头像
    NSString *imageUrlStr = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"新控制器";
    [self.navigationController pushViewController:newVc animated:YES];
}

@end
