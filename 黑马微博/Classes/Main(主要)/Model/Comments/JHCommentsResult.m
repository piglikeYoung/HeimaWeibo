//
//  JHCommentsResult.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHCommentsResult.h"
#import "MJExtension.h"
#import "JHComment.h"

@implementation JHCommentsResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [JHComment class]};
}

@end
