//
//  JHStatusLabel.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/12.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusLabel.h"
#import "JHLink.h"

@interface JHStatusLabel()

@property (weak , nonatomic) UITextView *textView;
@property (strong , nonatomic) NSMutableArray *links;

@end

@implementation JHStatusLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc] init];
        // 不能编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置TextView不能跟用户交互，最好把上边两个也一起设置，否则为微博内容有可能不显示
        textView.userInteractionEnabled = NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}

#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}

#pragma mark - 触摸事件处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 计算出所有的链接
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        NSString *linkText = attrs[JHLinkText];
        if (linkText == nil) return;
        
        // 设置选中的字符范围
        self.textView.selectedRange = range;
        // 算出选中的字符范围的边框
        NSArray *rects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
        for (UITextSelectionRect *selectionRect in rects) {
            if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) return;
            
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                // 添加背景到选中的范围
                UIView *bg = [[UIView alloc] init];
                bg.layer.cornerRadius = 3;
                bg.frame = selectionRect.rect;
                bg.backgroundColor = [UIColor yellowColor];
                [self insertSubview:bg atIndex:0];
            }
        }
        
    }];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}


@end
