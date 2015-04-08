//
//  JHStatusPhotosView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHStatusPhotosView : UIView

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
