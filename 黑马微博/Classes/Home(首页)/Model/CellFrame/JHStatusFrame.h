//
//  JHStatusFrame.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/7.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHStatus, JHStatusDetailFrame;

@interface JHStatusFrame : NSObject
/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) JHStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) JHStatus *status;
@end