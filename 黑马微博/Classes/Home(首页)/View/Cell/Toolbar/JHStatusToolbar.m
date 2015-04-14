//
//  JHStatusToolbar.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusToolbar.h"
#import "JHStatus.h"

@interface JHStatusToolbar()

/** 用来保存两条竖线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation JHStatusToolbar

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int dividerCount = self.dividers.count;
    CGFloat dividerFirstX = self.width / (dividerCount + 1);
    CGFloat dividerH = self.height;
    
    // 设置分割线的frame
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 4;
        divider.height = dividerH;
        divider.centerX = (i + 1) * dividerFirstX;
        divider.centerY = dividerH * 0.5;
    }

}


- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"common_card_bottom_background"] drawInRect:rect];
}

@end
