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

@interface JHStatusDetailView()

@property (nonatomic, weak) JHStatusOriginalView *originalView;
@property (nonatomic, weak) JHStatusRetweetedView *retweetedView;

@end

@implementation JHStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {// 初始化子控件
        // 1.添加原创微博
        [self setupOriginalView];
        
        // 2.添加转发微博
        [self setupRetweetedView];
    }
    
    return self;
}


/**
 *  添加原创微博
 */
- (void)setupOriginalView
{
    JHStatusOriginalView *originalView = [[JHStatusOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}

/**
 *  添加转发微博
 */
- (void)setupRetweetedView
{
    JHStatusRetweetedView *retweetedView = [[JHStatusRetweetedView alloc] init];
    [self addSubview:retweetedView];
    self.retweetedView = retweetedView;
}


@end
