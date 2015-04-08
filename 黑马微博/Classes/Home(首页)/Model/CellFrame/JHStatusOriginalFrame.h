//
//  JHStatusOriginalFrame.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHStatus;

@interface JHStatusOriginalFrame : NSObject
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;

// 因为时间的frame需要随时计算，实时更新，不能只算一次，来源的frame依赖时间的frame，所以一并注释
/** 来源 */
//@property (nonatomic, assign) CGRect sourceFrame;
/** 时间 */
//@property (nonatomic, assign) CGRect timeFrame;


/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 微博数据 */
@property (nonatomic, strong) JHStatus *status;


@end
