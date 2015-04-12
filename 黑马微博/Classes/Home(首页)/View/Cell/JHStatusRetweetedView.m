//
//  JHStatusRetweetedView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusRetweetedView.h"
#import "JHStatusRetweetedFrame.h"
#import "JHStatus.h"
#import "JHUser.h"
#import "JHStatusPhotosView.h"
#import "JHStatusLabel.h"

@interface JHStatusRetweetedView()

/**  昵称 */
//@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) JHStatusLabel *textLabel;
/** 配图相册 */
@property (nonatomic, weak) JHStatusPhotosView *photosView;

@end

@implementation JHStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        // 设置转发的背景，原来是继承自UIView，现在继承自UIImageView
        self.image=[UIImage resizedImage:@"timeline_retweet_background"];
        self.highlightedImage=[UIImage resizedImage:@"timeline_retweet_background_highlighted"];
        
        // 1.呢称
//        UILabel *nameLabel = [[UILabel alloc] init];
//        nameLabel.font = JHStatusRetweetedNameFont;
//        nameLabel.textColor = JHStatusHighTextColor;
//        [self addSubview:nameLabel];
//        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        JHStatusLabel *textLabel = [[JHStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.配图相册
        JHStatusPhotosView *photosView = [[JHStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    
    return self;
    
}

- (void)setRetweetedFrame:(JHStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    JHStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
//    JHUser *user = retweetedStatus.user;
    
    // 1.昵称
//    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
//    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    // 2.正文（内容）
//    self.textLabel.text = retweetedStatus.text;
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage resizedImage:@"timeline_retweet_background"] drawInRect:rect];
//}

@end
