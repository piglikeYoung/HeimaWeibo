//
//  JHStatusRetweetedFrame.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusRetweetedFrame.h"
#import "JHStatus.h"
#import "JHUser.h"

@implementation JHStatusRetweetedFrame

- (void)setRetweetedStatus:(JHStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.呢称
    CGFloat nameX = JHStatusCellInset;
    CGFloat nameY = JHStatusCellInset;
    CGSize nameSize = [retweetedStatus.user.name sizeWithFont:JHStatusRetweetedNameFont];
    
    self.nameFrame = (CGRect){{nameX , nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + JHStatusCellInset;
    CGFloat maxW = JHScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:JHStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = JHScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
