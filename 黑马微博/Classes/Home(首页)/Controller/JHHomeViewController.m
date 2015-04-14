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
#import "JHAccountTool.h"
#import "JHAccount.h"
#import "UIImageView+WebCache.h"
#import "JHStatus.h"
#import "JHUser.h"
#import "MJExtension.h"
#import "JHLoadMoreFooter.h"
#import "JHStatusTool.h"
#import "JHUserTool.h"
#import "JHStatusCell.h"
#import "JHStatusFrame.h"
#import "JHStatusDetailViewController.h"

@interface JHHomeViewController () <JHPopMenuDelegate>

/**
 *  微博数组(存放着所有的微博frame数据)
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (weak , nonatomic) JHLoadMoreFooter *footer;
@property (weak , nonatomic) JHTitleButton *titleButton;
@property (weak , nonatomic) UIRefreshControl *refreshControl;

@end

@implementation JHHomeViewController

#pragma mark - 初始化
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JHColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏的内容
    [self setupNavBar];
    
    
    // 集成刷新控件
    [self setupRefresh];
    
    // 获得用户信息
    [self setupUserInfo];
    
    // 监听链接选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:JHLinkDidSelectedNotification object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  链接点中方法
 */
- (void)linkDidSelected:(NSNotification *)note
{
    NSString *linkText = note.userInfo[JHLinkText];
    // 包含http打开浏览器
    if ([linkText hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
    } else {
        // 跳转控制器
        JHLog(@"选中了非HTTP链接---%@", note.userInfo[JHLinkText]);
    }
}


/**
 *  获得用户信息
 */
- (void)setupUserInfo
{
    // 1.封装请求参数
    JHUserInfoParam *param = [JHUserInfoParam param];
    param.uid = [JHAccountTool account].uid;
    
    
    // 2.发送请求
    [JHUserTool userInfoWithParam:param success:^(JHUserInfoResult *user) {
                
        // 设置用户的昵称为标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储帐号信息
        JHAccount *account = [JHAccountTool account];
        account.name = user.name;
        [JHAccountTool save:account];

    } failure:^(NSError *error) {
        JHLog(@"请求失败-------%@", error);
    }];

}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    self.refreshControl = refreshControl;
    [self.tableView addSubview:refreshControl];
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];
    
    // 5.添加上拉加载更多控件
    JHLoadMoreFooter *footer = [JHLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}

#pragma mark - 加载微博数据


/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (JHStatus *status in statuses) {
        JHStatusFrame *frame = [[JHStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    
    return frames;
    
}

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    
    // 1.封装请求参数
    JHHomeStatusesParam *param = [JHHomeStatusesParam param];

    // 取出数组中第一个数据，存在就加载比数组晚数据，不存在就加载全部数据
    JHStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    JHStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        param.since_id = @([firstStatus.idstr longLongValue]);
    }

    // 2.发送GET请求
    [JHStatusTool homeStatusesWithParam:param success:^(JHHomeStatusesResult *result) {
        
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newFrames.count];
    } failure:^(NSError *error) {
        JHLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
}

#pragma mark - 加载更多的微博数据
/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    
    // 1.封装请求参数
    JHHomeStatusesParam *params = [JHHomeStatusesParam param];
    JHStatusFrame *lastStatusFrame =  [self.statusFrames lastObject];
    JHStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 2.发送GET请求
    [JHStatusTool homeStatusesWithParam:params success:^(JHHomeStatusesResult *result) {
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        JHLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
    
}

#pragma mark - 刷新
- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) { // 有数字
        // 转圈圈
        [self.refreshControl beginRefreshing];
        // 刷新数据
        [self loadNewStatuses:self.refreshControl];
    }
    
    // 是否回到tableview顶部
    if (fromSelf) {
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}


/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    
    // 0.清零提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;
    self.tabBarItem.badgeValue = nil;

    
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
    
    // 设置尺寸，高度在titleButton里setTitle方法里计算设置
    titleButton.height = 35;
    
    // 设置文字
    NSString *name = [JHAccountTool account].name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    
    
    // 设置图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    self.titleButton = titleButton;
}

#pragma mark - 私有方法
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

- (void)pop
{
    JHLog(@"pop---");
}

- (void)friendSearch
{
    JHLog(@"friendSearch---");
    
}


#pragma mark - 弹出菜单协议
- (void)popMenuDidDismissed:(JHPopMenu *)popMenu{
    JHTitleButton *titleButton = (JHTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 当tableView没有数据的时候，不显示footerView
    self.footer.hidden = self.statusFrames.count == 0;
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHStatusCell *cell = [JHStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHStatusDetailViewController *detail = [[JHStatusDetailViewController alloc] init];
    JHStatusFrame *frame = self.statusFrames[indexPath.row];
    detail.status = frame.status;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing)
    {
        return;
    }

    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }
}

@end
