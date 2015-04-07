//
//  JHStatusDetailFrame.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatusDetailFrame.h"
#import "JHStatus.h"
#import "JHStatusOriginalFrame.h"
#import "JHStatusRetweetedFrame.h"

@implementation JHStatusDetailFrame

- (void)setStatus:(JHStatus *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    JHStatusOriginalFrame *originalFrame = [[JHStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        JHStatusRetweetedFrame *retweetedFrame = [[JHStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    // 起始Y值往下移一段距离，让每个cell的顶部空出一小段距离
    CGFloat y = JHStatusCell_Y;
    CGFloat w = JHScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
