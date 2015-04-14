//
//  JHStatusDetailTopToolbar.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusDetailTopToolbar.h"
#import "JHStatus.h"

@interface JHStatusDetailTopToolbar()
/** 三角形 */
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
@property (weak, nonatomic) IBOutlet UIButton *retweetedButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *attitudeButton;
@property (nonatomic, weak) UIButton *selectedButton;
- (IBAction)buttonClick:(UIButton *)button;
@end

@implementation JHStatusDetailTopToolbar


+ (instancetype)toolbar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHStatusDetailTopToolbar" owner:nil options:nil] lastObject];
}


- (void)setStatus:(JHStatus *)status
{
    _status = status;
    
    [self setupBtnTitle:self.retweetedButton count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentButton count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.attitudeButton count:status.attitudes_count defaultTitle:@"赞"];
}

- (void)drawRect:(CGRect)rect
{
    rect.origin.y = 10;
    [[UIImage resizedImage:@"statusdetail_comment_top_background"] drawInRect:rect];
}

/**
 *  从xib中加载完毕后就会调用
 */
- (void)awakeFromNib
{
    // 1.设置按钮tag
    self.retweetedButton.tag = JHStatusDetailTopToolbarButtonTypeRetweeted;
    self.commentButton.tag = JHStatusDetailTopToolbarButtonTypeComment;
    
    // 设置背景色
    self.backgroundColor = JHGlobalBg;
}

- (void)setDelegate:(id<JHStatusDetailTopToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认点击了评论按钮
    [self buttonClick:self.commentButton];
}

/**
 *  监听按钮点击
 */
- (IBAction)buttonClick:(UIButton *)button {
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.控制箭头的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowView.centerX = button.centerX;
    }];
    
    // 3.通知代理
    if ([self.delegate respondsToSelector:@selector(topToolbar:didSelectedButton:)]) {
        [self.delegate topToolbar:self didSelectedButton:button.tag];
    }
}

/**
 *  设置按钮的文字
 *
 *  @param button       需要设置文字的按钮
 *  @param count        按钮显示的数字
 *  @param defaultTitle 数字为0时显示的默认文字
 */
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@", count / 10000.0, defaultTitle];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%d %@", count, defaultTitle];
    } else {
        defaultTitle = [NSString stringWithFormat:@"0 %@", defaultTitle];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}
@end
