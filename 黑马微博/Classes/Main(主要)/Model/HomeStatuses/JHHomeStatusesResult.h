//
//  JHHomeStatusesResult.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface JHHomeStatusesResult : NSObject

/** 微博数组（装着HMStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;

@end
