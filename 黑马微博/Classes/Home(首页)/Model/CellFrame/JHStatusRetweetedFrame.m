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
#import "JHStatusPhotosView.h"

@implementation JHStatusRetweetedFrame

- (void)setRetweetedStatus:(JHStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.呢称
//    CGFloat nameX = JHStatusCellInset;
//    CGFloat nameY = JHStatusCellInset * 0.5;
//    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
//    CGSize nameSize = [name sizeWithFont:JHStatusRetweetedNameFont];
//    
//    self.nameFrame = (CGRect){{nameX , nameY}, nameSize};
    
    // 2.正文
    CGFloat h = 0;
    CGFloat textX = JHStatusCellInset;
    CGFloat textY = JHStatusCellInset * 0.5;
    CGFloat maxW = JHScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    h = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
        CGSize photosSize = [JHStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + JHStatusCellInset;
    }
    
    
    // 4.工具条
    if (retweetedStatus.isDetail) {// 展示在微博正文里面， 需要显示toolbar
        CGFloat toolbarY = 0;
        CGFloat toolbarW = 200;
        CGFloat toolbarX = JHScreenW - toolbarW;
        CGFloat toolbarH = 20;
        if (retweetedStatus.pic_urls.count) {
            toolbarY = CGRectGetMaxY(self.photosFrame) + JHStatusCellInset;
        } else {
            toolbarY = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
        }
        self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        h = CGRectGetMaxY(self.toolbarFrame) + JHStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = JHScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
