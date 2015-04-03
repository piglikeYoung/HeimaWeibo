//
//  JHLoadMoreFooter.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHLoadMoreFooter.h"

@interface JHLoadMoreFooter()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;


@end

@implementation JHLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}

@end
