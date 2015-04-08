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
    CGFloat nameY = JHStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:JHStatusRetweetedNameFont];
    
    self.nameFrame = (CGRect){{nameX , nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + JHStatusCellInset * 0.5;
    CGFloat maxW = JHScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:JHStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
        CGFloat photosW = 300;
        CGFloat photosH = 300;
        self.photosFrame = CGRectMake(photosX, photosY, photosW, photosH);
        
        h = CGRectGetMaxY(self.photosFrame) + JHStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = JHScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
