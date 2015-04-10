//
//  JHEmotionListView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//


#import "JHEmotionListView.h"
#import "JHEmotionGridView.h"

@interface JHEmotionListView() <UIScrollViewDelegate>
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
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
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
    // 设置总页数
    self.pageControl.numberOfPages = (emotions.count + JHEmotionMaxCountPerPage - 1) / JHEmotionMaxCountPerPage;
    self.pageControl.currentPage = 0;
    
    // 移除之前的表情
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 决定scrollView显示多少页表情
    for (int i= 0; i < self.pageControl.numberOfPages; i++) {
        JHEmotionGridView *gridView = [[JHEmotionGridView alloc] init];
        int loc = i * JHEmotionMaxCountPerPage;
        int len = JHEmotionMaxCountPerPage;
        // 如果超过了总数，该页的显示表情数 = 表情总数 - 该页起始表情索引
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        [self.scrollView addSubview:gridView];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚到最前面
    self.scrollView.contentOffset = CGPointZero;
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
    
    // 3.设置UIScrollView内部控件的尺寸
    int count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        JHEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滑动显示的页码
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
