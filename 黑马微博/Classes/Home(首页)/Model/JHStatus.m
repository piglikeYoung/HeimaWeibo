//
//  JHStatus.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHStatus.h"
#import "MJExtension.h"
#import "JHPhoto.h"

@implementation JHStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JHPhoto class]};
}

@end
