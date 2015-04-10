//
//  JHEmotionGridView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionGridView.h"
#import "JHEmotion.h"
#import "JHEmotionView.h"

@interface JHEmotionGridView()

@property (nonatomic, weak) UIButton *deleteButton;
/** 存放每个表情按钮，方便排列表情， 否则利用subView取出排列的第一个button是删除按钮 */
@property (nonatomic, strong) NSMutableArray *emotionViews;

@end

@implementation JHEmotionGridView

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = emotions.count;
    int currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i < count; i++) {
        JHEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) {// emotionView不够用
            emotionView = [[JHEmotionView alloc] init];
            emotionView.backgroundColor = JHRandomColor;
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else {// emotionView够用
            emotionView = self.emotionViews[i];
        }
        
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
        
        // 隐藏多余的emotionView
        for (int i = count; i < currentEmotionViewCount; i++) {
            UIButton *emotionView = self.emotionViews[i];
            emotionView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    // 每个表情button之前没有空隙连成一个整体
    int count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / JHEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / JHEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % JHEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / JHEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}


@end
