//
//  JHStatusPhotosView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusPhotosView.h"

@implementation JHStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    CGFloat photoW = 70;
    CGFloat photoH = photoW;
    CGFloat photoMargin = 10;
    
    // 一行最多几列
    int maxCols = 3;
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    // 知道总个数
    // 知道每一页最多显示多少个
    // 能算出一共能显示多少页
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * photoW + (totalCols - 1) * photoMargin;
    CGFloat photosH = totalRows * photoH + (totalRows - 1) * photoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
