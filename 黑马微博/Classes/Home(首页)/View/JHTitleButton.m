//
//  JHTitleButton.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/30.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHTitleButton.h"

@implementation JHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 字体
        self.titleLabel.font = JHNavigationTitleFont;
        
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;

    }
    
    return self;
}

/**
 *  设置内部图标的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    // 将图片设置成正方形，减少计算量，宽度和高度相等，都等于按钮的高度
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.height;
    CGFloat imageH = imageW;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = contentRect.size.width - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}

@end
