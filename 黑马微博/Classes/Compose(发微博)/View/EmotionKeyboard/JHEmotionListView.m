//
//  JHEmotionListView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

// 表情的最大行数
#define JHEmotionMaxRows 3
// 表情的最大列数
#define JHEmotionMaxCols 7
// 每页最多显示多少个表情
#define JHEmotionMaxCountPerPage (JHEmotionMaxRows * JHEmotionMaxCols - 1)

#import "JHEmotionListView.h"

@interface JHEmotionListView()
/** 显示所有表情的UIScrollView */
@property (weak , nonatomic) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (weak , nonatomic) UIPageControl *pageControl;

@end

@implementation JHEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor redColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}


- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    JHLog(@"----%d", emotions.count);
    // 设置总页数
    self.pageControl.numberOfPages = (emotions.count + JHEmotionMaxCountPerPage - 1) / JHEmotionMaxCountPerPage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
}


@end
