//
//  JHStatusTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.


#import "JHStatusTool.h"

@implementation JHStatusTool

+(void)homeStatusesWithParam:(JHHomeStatusesParam *)param success:(void (^)(JHHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[JHHomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(JHSendStatusParam *)param success:(void (^)(JHSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[JHSendStatusResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(JHSendStatusParam *)param formDataArray:(NSArray *)formDataArray success:(void (^)(JHSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" param:param formDataArray:formDataArray resultClass:[JHSendStatusResult class] success:success failure:failure];
}

+ (void)commentsWithParam:(id)param success:(void (^)(JHCommentsResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/comments/show.json" param:param resultClass:[JHCommentsResult class] success:success failure:failure];
}

@end
