//
//  JHStatusPhotosView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//  微博cell里面的相册 -- 里面包含N个JHStatusPhotoView

#import <UIKit/UIKit.h>

@interface JHStatusPhotosView : UIView

/**
 *  图片数据（里面都是JHPhoto模型）
 */
@property (strong , nonatomic) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
