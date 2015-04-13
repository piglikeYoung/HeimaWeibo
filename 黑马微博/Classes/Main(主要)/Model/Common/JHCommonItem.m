//
//  JHCommonItem.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHCommonItem.h"

@implementation JHCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    JHCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
