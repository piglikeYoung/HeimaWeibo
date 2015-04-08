//
//  JHStatusPhotosView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusPhotosView.h"
#import "JHStatusPhotoView.h"

#define JHStatusPhotosMaxCount 9
// 判断最大列数，如果图片是4张，显示2列，图片为田字，不是4张，显示3列
#define JHStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define JHStatusPhotoW 70
#define JHStatusPhotoH JHStatusPhotoW
#define JHStatusPhotoMargin 10

@implementation JHStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 预先创建9个图片view
        for (int i = 0; i<JHStatusPhotosMaxCount; i++) {
            JHStatusPhotoView *photoView = [[JHStatusPhotoView alloc] init];
            [self addSubview:photoView];
        }
        
    }
    
    return self;
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
