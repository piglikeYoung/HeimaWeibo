//
//  JHStatusDetailFrame.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHStatus, JHStatusOriginalFrame, JHStatusRetweetedFrame;

@interface JHStatusDetailFrame : NSObject

@property (nonatomic, strong) JHStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) JHStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) JHStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;

@end
