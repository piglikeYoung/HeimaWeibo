//
//  JHUserTool.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHBaseTool.h"
#import "JHUserInfoParam.h"
#import "JHUserInfoResult.h"
#import "JHUnreadCountParam.h"
#import "JHUnreadCountResult.h"

@interface JHUserTool : JHBaseTool

/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(JHUserInfoParam *)param success:(void (^)(JHUserInfoResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  加载用户的的未读信息数
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParam:(JHUnreadCountParam *)param success:(void (^)(JHUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
