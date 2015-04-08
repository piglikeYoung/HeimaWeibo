//
//  JHStatusPhotosView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusPhotosView.h"
#import "JHStatusPhotoView.h"
#import "JHPhoto.h"
#import "UIImageView+WebCache.h"

#define JHStatusPhotosMaxCount 9
// 判断最大列数，如果图片是4张，显示2列，图片为田字，不是4张，显示3列
#define JHStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define JHStatusPhotoW 70
#define JHStatusPhotoH JHStatusPhotoW
#define JHStatusPhotoMargin 10


@interface JHStatusPhotosView()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation JHStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 预先创建9个图片view
        for (int i = 0; i<JHStatusPhotosMaxCount; i++) {
            JHStatusPhotoView *photoView = [[JHStatusPhotoView alloc] init];
            [self addSubview:photoView];
            
            // 添加手势监听器(一个手势监听器 只能 监听对应的一个view，所以放在循环每次创建新的)
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
        
    }
    
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.添加一个遮盖
    UIView *cover = [[UIView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    // 2.添加图片到遮盖上
    JHStatusPhotoView *photoView = (JHStatusPhotoView *)recognizer.view;
    UIImageView *imageView = [[UIImageView alloc] init];
    // 去下载大图
    [imageView sd_setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
    
    // 将photoView.frame从它自己原来位置坐标系转为当前cover的坐标系
    imageView.frame = [cover convertRect:photoView.frame fromView:self];
    // 记录放大前的frame，恢复小图的时候用到
    self.lastFrame = imageView.frame;
    [cover addSubview:imageView];
    self.imageView = imageView;
    
    // 3.放大
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = cover.width; // 屏幕宽度
        // 等比例高度
        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (cover.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}

/**
 *  恢复小图，取消遮盖
 */
- (void)tapCover:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5 animations:^{
        recognizer.view.backgroundColor = [UIColor clearColor];
        // 将大图变回原来小图的位置
        self.imageView.frame = self.lastFrame;
    } completion:^(BOOL finished) {
        [recognizer.view removeFromSuperview];
        self.imageView = nil;
    }];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < JHStatusPhotosMaxCount; i++) {
        JHStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) {// 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else {
            // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = JHStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        JHStatusPhotoView *photoView = self.subviews[i];
        photoView.width = JHStatusPhotoW;
        photoView.height = JHStatusPhotoH;
        photoView.x = (i % maxCols) * (JHStatusPhotoW + JHStatusPhotoMargin);
        photoView.y = (i / maxCols) * (JHStatusPhotoH + JHStatusPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    
    // 一行最多几列
    int maxCols = JHStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    // 知道总个数
    // 知道每一页最多显示多少个
    // 能算出一共能显示多少页
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * JHStatusPhotoW + (totalCols - 1) * JHStatusPhotoMargin;
    CGFloat photosH = totalRows * JHStatusPhotoH + (totalRows - 1) * JHStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
