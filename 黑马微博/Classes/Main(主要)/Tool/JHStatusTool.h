//
//  JHStatusTool.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//  微博业务类：处理跟微博相关的一切业务，比如加载微博数据、发微博、删微博

#import <Foundation/Foundation.h>
#import "JHHomeStatusesParam.h"
#import "JHHomeStatusesResult.h"
#import "JHSendStatusParam.h"
#import "JHSendStatusResult.h"
#import "JHCommentsParam.h"
#import "JHCommentsResult.h"
#import "JHBaseTool.h"

@interface JHStatusTool : JHBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(JHHomeStatusesParam *)param success:(void (^)(JHHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(JHSendStatusParam *)param success:(void (^)(JHSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  发有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(JHSendStatusParam *)param formDataArray:(NSArray *)formDataArray  success:(void (^)(JHSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  加载评论数据
 */
+ (void)commentsWithParam:(JHCommentsParam *)param success:(void (^)(JHCommentsResult *result))success failure:(void (^)(NSError *error))failure;

@end
