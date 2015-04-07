//
//  JHUser.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHUser.h"

@implementation JHUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

@end
