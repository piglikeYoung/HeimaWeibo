//
//  JHUserTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHUserTool.h"

@implementation JHUserTool

+ (void)userInfoWithParam:(JHUserInfoParam *)param success:(void (^)(JHUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[JHUserInfoResult class] success:success failure:failure];
}

+ (void)unreadCountWithParam:(JHUnreadCountParam *)param success:(void (^)(JHUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[JHUnreadCountResult class] success:success failure:failure];
}

@end
