//
//  JHStatusPhotoView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//  一个JHStatusPhotoView代表1张配图

#import <UIKit/UIKit.h>
@class JHPhoto;

@interface JHStatusPhotoView : UIImageView

@property (strong , nonatomic) JHPhoto *photo;

@end
