//
//  JHStatusRetweetedFrame.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHStatus;

@interface JHStatusRetweetedFrame : NSObject

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 转发微博的数据 */
@property (nonatomic, strong) JHStatus *retweetedStatus;

@end
