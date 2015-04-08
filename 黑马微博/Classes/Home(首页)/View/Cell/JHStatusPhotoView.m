//
//  JHStatusPhotoView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/8.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusPhotoView.h"
#import "JHPhoto.h"
#import "UIImageView+WebCache.h"

@interface JHStatusPhotoView()

@property (weak , nonatomic) UIImageView *gifView;

@end

@implementation JHStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
        // 这种情况下创建的UIImageView是没有尺寸的
        //        UIImageView *gifView1 = [[UIImageView alloc] init];
        //        gifView1.image = image;
    }
    
    return self;
}

- (void)setPhoto:(JHPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
