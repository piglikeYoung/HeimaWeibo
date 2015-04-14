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
#import "JHStatusPhotosView.h"

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
    
    // 计算会员图标位置
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + JHStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /*
    // 3.时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + JHStatusCellInset * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusOrginalTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + JHStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusOrginalSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    */
    
    // 5.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + JHStatusCellInset;
    CGFloat maxW = JHScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    // 删掉最前面的昵称
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
    if (status.isRetweeted) {
        int len = status.user.name.length + 4;
        [text deleteCharactersInRange:NSMakeRange(0, len)];
    }
    
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 6.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
        CGSize photosSize = [JHStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + JHStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + JHStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = JHScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
