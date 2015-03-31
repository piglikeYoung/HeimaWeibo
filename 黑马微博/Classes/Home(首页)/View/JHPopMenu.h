//
//  JHPopMenu.h
//  黑马微博
//
//  Created by piglikeyoung on 15/3/30.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

// 弹出框突起的位置
typedef enum {
    JHPopMenuArrowPositionCenter = 0,
    JHPopMenuArrowPositionLeft,
    JHPopMenuArrowPositionRight
} JHPopMenuArrowPosition;

@class JHPopMenu;

@protocol JHPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(JHPopMenu *)popMenu;

@end

@interface JHPopMenu : UIView

@property (weak , nonatomic) id<JHPopMenuDelegate> delegate;

// 是否开启遮罩的阴影效果
@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

// 设置弹出框突起的位置
@property (nonatomic, assign) JHPopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end
