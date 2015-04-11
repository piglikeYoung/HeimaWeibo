//
//  JHEmotionTextView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHTextView.h"
@class JHEmotion;

@interface JHEmotionTextView : JHTextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(JHEmotion *)emotion;
@end
