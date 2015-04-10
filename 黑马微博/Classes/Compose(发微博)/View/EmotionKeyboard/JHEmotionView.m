//
//  JHEmotionView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionView.h"
#import "JHEmotion.h"

@implementation JHEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

- (void)setEmotion:(JHEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        // emotion.code == 0x1f603 --> \u54367
        // emoji的大小取决于字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        [self setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
