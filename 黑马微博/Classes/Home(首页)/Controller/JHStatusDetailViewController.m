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
#import "JHStatusTool.h"
#import "JHComment.h"
#import "JHStatusDetailTopToolbar.h"
#import "MBProgressHUD+MJ.h"

@interface JHStatusDetailViewController ()<UITableViewDataSource, UITableViewDelegate, JHStatusDetailTopToolbarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) JHStatusDetailTopToolbar *topToolbar;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *reposts;
@end

@implementation JHStatusDetailViewController

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

- (NSMutableArray *)reposts
{
    if (_reposts == nil) {
        self.reposts = [NSMutableArray array];
    }
    return _reposts;
}



- (JHStatusDetailTopToolbar *)topToolbar
{
    if (!_topToolbar) {
        self.topToolbar = [JHStatusDetailTopToolbar toolbar];
        self.topToolbar.status = self.status;
        self.topToolbar.delegate = self;
    }
    return _topToolbar;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    
    // 创建tableView
    [self setupTableView];
    
    // 创建微博详情控件
    [self setupDetailView];
    
    // 创建底部工具条
    [self setupBottomToolbar];
    
    
}

/**
 *  创建底部工具条
 */
- (void)setupBottomToolbar
{
    JHStatusDetailBottomToolbar *bottomToolbar = [[JHStatusDetailBottomToolbar alloc] init];
    bottomToolbar.y = CGRectGetMaxY(self.tableView.frame);
    bottomToolbar.width = self.view.width;
    bottomToolbar.height = self.view.height - self.tableView.height;
    [self.view addSubview:bottomToolbar];

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
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView.backgroundColor = JHGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topToolbar.selectedButtonType == JHStatusDetailTopToolbarButtonTypeComment) {
        return self.comments.count;
    } else {
        return self.reposts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (self.topToolbar.selectedButtonType == JHStatusDetailTopToolbarButtonTypeComment) {
        JHComment *cmt = self.comments[indexPath.row];
        cell.textLabel.text = cmt.text;
    } else {
        JHStatus *status = self.reposts[indexPath.row];
        cell.textLabel.text = status.text;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolbar;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.topToolbar.height;
}

#pragma mark - 顶部工具条的代理
- (void)topToolbar:(JHStatusDetailTopToolbar *)topToolbar didSelectedButton:(JHStatusDetailTopToolbarButtonType)buttonType
{
    // 刷新数据
    [self.tableView reloadData];
    switch (buttonType) {
        case JHStatusDetailTopToolbarButtonTypeComment: // 评论
            [self loadComments];
            break;
            
        case JHStatusDetailTopToolbarButtonTypeRetweeted: // 转发
            [self loadRetweeteds];
            break;
    }
}

/**
 *  加载评论数据
 */
- (void)loadComments
{
    JHCommentsParam *param = [JHCommentsParam param];
    param.id = self.status.idstr;
    JHComment *cmt = [self.comments firstObject];
    param.since_id = cmt.idstr;
    
    [JHStatusTool commentsWithParam:param success:^(JHCommentsResult *result) {
        // 评论
        self.status.comments_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        [self.comments insertObjects:result.comments atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

/**
 *  加载转发数据
 */
- (void)loadRetweeteds
{
    JHRepostsParam *param = [JHRepostsParam param];
    param.id = self.status.idstr;
    JHStatus *status = [self.reposts firstObject];
    param.since_id = status.idstr;
    
    [JHStatusTool repostsWithParam:param success:^(JHRepostsResult *result) {
        // 转发总数
        self.status.reposts_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.reposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}


@end
