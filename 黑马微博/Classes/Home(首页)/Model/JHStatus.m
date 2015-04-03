//
//  JHStatus.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatus.h"
#import "JHUser.h"

@implementation JHStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    JHStatus *status = [[self alloc] init];
    
    status.text = dict[@"text"];
    
    status.user = [JHUser userWithDict:dict[@"user"]];
    
    NSDictionary *retweetedDict = dict[@"retweeted_status"];
    if (retweetedDict) {
        status.retweeted_status = [JHStatus statusWithDict:retweetedDict];
    }
    
    return status;
}

@end
