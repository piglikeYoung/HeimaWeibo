//
//  JHEmotionTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#define JHRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

#import "JHEmotionTool.h"
#import "JHEmotion.h"
#import "MJExtension.h"

@implementation JHEmotionTool

/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [JHEmotion objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [JHEmotion objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [JHEmotion objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions
{
    if (!_recentEmotions) {
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JHRecentFilepath];
        if (!_recentEmotions) {// 沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

// Emoji的plist里面加载的表情
+ (void)addRecentEmotion:(JHEmotion *)emotion
{
    // 加载最近的表情数据
    [self recentEmotions];
    
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:JHRecentFilepath];
}

@end
