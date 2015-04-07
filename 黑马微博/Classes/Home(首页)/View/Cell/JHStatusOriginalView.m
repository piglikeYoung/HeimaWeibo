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

@interface JHStatusOriginalView()

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;

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
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = JHStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = JHStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = JHStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
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
    
    // 2.正文（内容）
    self.textLabel.text = status.text;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 3.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = originalFrame.timeFrame;
    
    // 4.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = originalFrame.sourceFrame;
    
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
}
@end
