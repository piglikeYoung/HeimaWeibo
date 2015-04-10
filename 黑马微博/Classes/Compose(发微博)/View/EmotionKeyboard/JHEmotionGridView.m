//
//  JHEmotionGridView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionGridView.h"
#import "JHEmotion.h"

@implementation JHEmotionGridView


- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = emotions.count;
    for (int i = 0; i < count; i++) {
        
        // 使用button，是因为emoji表情不是图片是字符，button既能显示图片又能显示文字
        UIButton *emotionView = [[UIButton alloc] init];
        emotionView.adjustsImageWhenHighlighted = NO;
        JHEmotion *emotion = emotions[i];
        if (emotion.code) { // emoji表情
            // emotion.code == 0x1f603 --> \u54367
            // emoji的大小取决于字体大小
            emotionView.titleLabel.font = [UIFont systemFontOfSize:32];
            [emotionView setTitle:emotion.emoji forState:UIControlStateNormal];
        } else {
            NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
            [emotionView setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
        }
        
        [self addSubview:emotionView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 每个表情button之前没有空隙连成一个整体
    int count = self.emotions.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / JHEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / JHEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *emotionView = self.subviews[i];
        emotionView.x = leftInset + (i % JHEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / JHEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
}


@end
