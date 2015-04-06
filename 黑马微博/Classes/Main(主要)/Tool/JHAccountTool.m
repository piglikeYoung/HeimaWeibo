//
//  HMAccountTool.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//


#import "JHAccountTool.h"
#import "JHAccount.h"

#define JHAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation JHAccountTool


+ (void)save:(JHAccount *)account
{
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:JHAccountFilepath];
}

+ (JHAccount *)account
{
    // 读取帐号
    JHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:JHAccountFilepath];
    
    NSDate *now = [NSDate date];
    
    // 判断帐号是否已经过期
    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    
    return account;
    
    /**
     NSOrderedAscending = -1L,  升序，越往右边越大
     NSOrderedSame, 相等，一样
     NSOrderedDescending 降序，越往右边越小
     */
}

+ (void)accessTokenWithParam:(JHAccessTokenParam *)param success:(void (^)(JHAccount *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[JHAccount class] success:success failure:failure];
}





@end
