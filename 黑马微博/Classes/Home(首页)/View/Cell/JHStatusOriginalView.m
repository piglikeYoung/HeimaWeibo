//
//  JHStatusOriginalView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusOriginalView.h"
#import "JHStatusOriginalFrame.h"
#import "JHStatus.h"
#import "JHUser.h"
#import "UIImageView+WebCache.h"
#import "JHStatusPhotosView.h"
#import "JHStatusLabel.h"

@interface JHStatusOriginalView()

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) JHStatusLabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;

/** 配图相册 */
@property (weak , nonatomic) JHStatusPhotosView *photosView;

@end

@implementation JHStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = JHStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        JHStatusLabel *textLabel = [[JHStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = JHStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = JHStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 7.配图相册
        JHStatusPhotosView *photosView = [[JHStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(JHStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    JHStatus *status = originalFrame.status;
    // 取出用户数据
    JHUser *user = status.user;
    
    // 1.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    
    // 判断是否会员，防止循环引用
    if (user.isVip) {// 是会员
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 2.正文（内容）
//    self.textLabel.text = status.text;
    // 如果是转发微博的正文，不显示用户名
    // 隐藏最前面的昵称
    if (status.isRetweeted){
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
        int len = user.name.length + 4;// 有2个空格和一个:
        [text deleteCharactersInRange:NSMakeRange(0, len)];
        self.textLabel.attributedText = text;
    } else {
        self.textLabel.attributedText = status.attributedText;
    }

    self.textLabel.frame = originalFrame.textFrame;
    
#warning 需要时刻根据现在的时间字符串来计算时间label的frame
    // 3.时间
    self.timeLabel.text = status.created_at; // 刚刚 --> 1分钟前 --> 10分钟前
//    self.timeLabel.frame = originalFrame.timeFrame;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + JHStatusCellInset * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusOrginalTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    
    // 4.来源
    self.sourceLabel.text = status.source;
//    self.sourceLabel.frame = originalFrame.sourceFrame;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + JHStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusOrginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    // 6.配图相册
    if (status.pic_urls.count) { // 有配图
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}
@end
