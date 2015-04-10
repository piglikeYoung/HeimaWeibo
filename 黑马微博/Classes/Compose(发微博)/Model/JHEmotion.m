//
//  JHEmotion.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotion.h"
#import "NSString+Emoji.h"

@implementation JHEmotion
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    
    self.emoji = [NSString emojiWithStringCode:code];
}

@end
