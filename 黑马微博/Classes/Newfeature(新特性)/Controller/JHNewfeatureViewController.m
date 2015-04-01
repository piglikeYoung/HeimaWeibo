//
//  JHNewfeatureViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/1.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#define JHNewfeatureImageCount 4

#import "JHNewfeatureViewController.h"

@interface JHNewfeatureViewController () <UIScrollViewDelegate>

@property (weak , nonatomic) UIPageControl *pageControl;

@end

@implementation JHNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupPageControl];

}


/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i<JHNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        if (FourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
            name = [name stringByAppendingString:@"-568h"];
        }
        imageView.image = [UIImage imageWithName:name];
        
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
    }
    
    // 3.设置其他属性
    // 设置活动范围
    scrollView.contentSize = CGSizeMake(JHNewfeatureImageCount * imageW, 0);
    // 分页效果
    scrollView.pagingEnabled = YES;
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置背景颜色
    scrollView.backgroundColor = JHColor(246, 246, 246);
}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = JHNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = JHColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = JHColor(189, 189, 189); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    // 拿到浮点数进行四舍五入
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}

#pragma mark - 隐藏状态栏
- (BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
