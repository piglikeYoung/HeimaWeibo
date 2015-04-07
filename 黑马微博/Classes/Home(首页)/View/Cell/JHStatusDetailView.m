//
//  JHStatusDetailView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusDetailView.h"
#import "JHStatusRetweetedView.h"
#import "JHStatusOriginalView.h"
#import "JHStatusDetailFrame.h"

@interface JHStatusDetailView()

@property (nonatomic, weak) JHStatusOriginalView *originalView;
@property (nonatomic, weak) JHStatusRetweetedView *retweetedView;

@end

@implementation JHStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {// 初始化子控件
        
        // 设置除了工具条之外的背景
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        // 1.添加原创微博
        JHStatusOriginalView *originalView = [[JHStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 2.添加转发微博
        JHStatusRetweetedView *retweetedView = [[JHStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    
    return self;
}


- (void)setDetailFrame:(JHStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 2.原创转发的frame数据
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}


@end
