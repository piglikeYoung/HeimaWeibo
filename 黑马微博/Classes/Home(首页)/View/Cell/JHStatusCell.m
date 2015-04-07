//
//  JHStatusCell.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusCell.h"
#import "JHStatusDetailView.h"
#import "JHStatusToolbar.h"

@interface JHStatusCell()

@property (nonatomic, weak) JHStatusDetailView *detailView;
@property (nonatomic, weak) JHStatusToolbar *toolbar;

@end

@implementation JHStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) { // 初始化子控件
        // 1.添加微博具体内容
        [self setupDetailView];
        
        // 2.添加工具条
        [self setupToolbar];
    }
    return self;
}


/**
 *  添加微博具体内容
 */
- (void)setupDetailView
{
    JHStatusDetailView *detailView = [[JHStatusDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}

/**
 *  添加工具条
 */
- (void)setupToolbar
{
    JHStatusToolbar *toolbar = [[JHStatusToolbar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

@end
