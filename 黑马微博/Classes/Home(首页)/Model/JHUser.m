//
//  JHUser.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHUser.h"

@implementation JHUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    JHUser *user = [[self alloc] init];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

@end
