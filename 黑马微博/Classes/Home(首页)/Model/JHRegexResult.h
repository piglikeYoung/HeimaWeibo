//
//  JHRegexResult.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/12.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//  用来封装一个正则表达式匹配结果

#import <Foundation/Foundation.h>

@interface JHRegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;

@end
