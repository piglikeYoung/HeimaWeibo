//
//  JHStatusOriginalFrame.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusOriginalFrame.h"
#import "JHStatus.h"
#import "JHUser.h"

@implementation JHStatusOriginalFrame

- (void)setStatus:(JHStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = JHStatusCellInset;
    CGFloat iconY = JHStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + JHStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:JHStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 3.时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + JHStatusCellInset;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusOrginalTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + JHStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusOrginalSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + JHStatusCellInset;
    CGFloat maxW = JHScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:JHStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = JHScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
