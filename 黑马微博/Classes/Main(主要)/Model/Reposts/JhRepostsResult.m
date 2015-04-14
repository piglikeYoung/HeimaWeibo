//
//  JhRepostsResult.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHRepostsResult.h"
#import "MJExtension.h"
#import "JHStatus.h"

@implementation JHRepostsResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [JHStatus class]};
}


@end
