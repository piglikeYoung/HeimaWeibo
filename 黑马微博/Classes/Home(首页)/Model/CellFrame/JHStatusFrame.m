//
//  JHStatusFrame.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusFrame.h"
#import "JHStatus.h"
#import "JHStatusDetailFrame.h"

@implementation JHStatusFrame

- (void)setStatus:(JHStatus *)status
{
    _status = status;
    
    // 1.计算微博具体内容（微博整体）
    [self setupDetailFrame];
    
    // 2.计算底部工具条
    [self setupToolbarFrame];
    
    // 3.计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

/**
 *  计算微博具体内容（微博整体）
 */
- (void)setupDetailFrame
{
    JHStatusDetailFrame *detailFrame = [[JHStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}

/**
 *  计算底部工具条
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = JHScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}


@end
