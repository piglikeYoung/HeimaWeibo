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
#import "JHStatusFrame.h"

@interface JHStatusCell()

@property (nonatomic, weak) JHStatusDetailView *detailView;
@property (nonatomic, weak) JHStatusToolbar *toolbar;

@end

@implementation JHStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
    JHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JHStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) { // 初始化子控件
        // 1.添加微博具体内容
        JHStatusDetailView *detailView = [[JHStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 2.添加工具条
        JHStatusToolbar *toolbar = [[JHStatusToolbar alloc] init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

- (void)setStatusFrame:(JHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.微博具体内容的frame数据
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 2.底部工具条的frame数据
    self.toolbar.frame = statusFrame.toolbarFrame;
}

@end
