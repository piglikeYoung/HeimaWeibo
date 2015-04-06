//
//  JHHomeStatusesResult.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHHomeStatusesResult.h"
#import "MJExtension.h"
#import "JHStatus.h"

@implementation JHHomeStatusesResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [JHStatus class]};
}

@end
