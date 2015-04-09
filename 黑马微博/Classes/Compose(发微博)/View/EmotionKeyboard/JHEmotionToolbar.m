//
//  JHEmotionToolbar.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#define JHEmotionToolbarButtonMaxCount 4

#import "JHEmotionToolbar.h"

@interface JHEmotionToolbar()

/** 记录当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation JHEmotionToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:JHEmotionTypeRecent];
        UIButton *defaultButton = [self setupButton:@"默认" tag:JHEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:JHEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:JHEmotionTypeLxh];
        
        // 2.默认选中“默认”按钮
        [self buttonClick:defaultButton];
    }
    return self;
}


/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(JHEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    int count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == JHEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / JHEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i<JHEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end
