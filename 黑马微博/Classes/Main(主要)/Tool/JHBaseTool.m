//
//  HMBaseTool.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHBaseTool.h"
#import "JHHttpTool.h"
#import "MJExtension.h"

@implementation JHBaseTool

+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    
    [JHHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    
    [JHHttpTool post:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param formDataArray:(NSArray *)formDataArray resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    
    [JHHttpTool post:url params:params formDataArray:formDataArray success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
