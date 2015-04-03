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
#import "MJExtension.h"

@interface JHHomeViewController () <JHPopMenuDelegate>

/**
 *  微博数组(存放着所有的微博数据)
 */
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation JHHomeViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏的内容
    [self setupNavBar];
    
    
    // 集成刷新控件
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];
}

/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JHAccountTool account].access_token;
    
    // 取出数组中第一个数据，存在就加载比数组晚数据，不存在就加载全部数据
    JHStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 3.发送GET请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
        // JHLog(@"请求成功--%@", resultDict);
        
        // 赋值数组数据
        NSArray *statusDictArray = resultDict[@"statuses"];
        // 微博字典数组 ---> 微博模型数组
        NSArray *newStatuses = [JHStatus objectArrayWithKeyValuesArray:statusDictArray];
        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    } else {
        label.text = @"没有最新的微博数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
        
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
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
