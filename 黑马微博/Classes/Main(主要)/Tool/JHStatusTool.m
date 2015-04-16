//
//  JHStatusTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.


#import "JHStatusTool.h"
#import "FMDB.h"
#import "JHStatus.h"
#import "MJExtension.h"
#import "JHHttpTool.h"

@implementation JHStatusTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"status.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
        if (result) {
            JHLog(@"成功创表");
        } else {
            JHLog(@"创表失败");
        }
    }
}


+ (void)homeStatusesWithParam:(JHHomeStatusesParam *)param success:(void (^)(JHHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    
    // 从数据库中读取（加载）缓存数据(微博模型数组)
    NSArray *cachedHomeStatuses = [self cachedHomeStatusesWithParam:param];
    if (cachedHomeStatuses.count != 0) { // 有缓存数据
        if (success) {
            JHHomeStatusesResult *result = [[JHHomeStatusesResult alloc] init];
            result.statuses = cachedHomeStatuses;
            success(result);
        }
    } else { // 没有缓存数据
        NSDictionary *params = [param keyValues];
        
        [JHHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
            // 新浪返回的字典数组
            NSArray *statusDictArray = responseObj[@"statuses"];
            
            // 缓存微博字典数组
            [self saveHomeStatusDictArray:statusDictArray accessToken:param.access_token];
            
            if (success) {
                JHHomeStatusesResult *result = [JHHomeStatusesResult objectWithKeyValues:responseObj];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

/**
 *  通过请求参数去数据库中加载对应的微博数据
 *
 *  @param param 请求参数
 */
+ (NSArray *)cachedHomeStatusesWithParam:(JHHomeStatusesParam *)param
{
    // 创建数组缓存微博数据
    NSMutableArray *statuses = [NSMutableArray array];
    
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    if (param.since_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr > ? ORDER BY status_idstr DESC limit ?;", param.access_token, param.since_id, param.count];
    } else if (param.max_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr DESC limit ?;", param.access_token, param.max_id, param.count];
    } else {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? ORDER BY status_idstr DESC limit ?;", param.access_token, param.count];
    }
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *statusDictData = [resultSet objectForColumnName:@"status_dict"];
        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];
        // 字典转模型
        JHStatus *status = [JHStatus objectWithKeyValues:statusDict];
        // 添加模型到数组中
        [statuses addObject:status];
    }
    
    return statuses;
}

/**
 *  缓存微博字典数组到数据库中
 */
+ (void)saveHomeStatusDictArray:(NSArray *)statusDictArray accessToken:(NSString *)accessToken
{
    for (NSDictionary *statusDict in statusDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        [_db executeUpdate:@"INSERT INTO t_home_status (access_token, status_idstr, status_dict) VALUES (?, ?, ?);",
         accessToken, statusDict[@"idstr"], data];
    }
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

+ (void)repostsWithParam:(JHRepostsParam *)param success:(void (^)(JHRepostsResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/repost_timeline.json" param:param resultClass:[JHRepostsResult class] success:success failure:failure];
}

@end
