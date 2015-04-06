//
//  JHBaseParam.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHBaseParam.h"
#import "JHAccountTool.h"
#import "JHAccount.h"

@implementation JHBaseParam

- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [JHAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

@end
