//
//  JHStatusTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.


#import "JHStatusTool.h"
#import "JHHttpTool.h"
#import "MJExtension.h"

@implementation JHStatusTool

+(void)homeStatusesWithParam:(JHHomeStatusesParam *)param success:(void (^)(JHHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = param.keyValues;
    
    [JHHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
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

@end
