//
//  HMAccountTool.h
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHAccount;

@interface JHAccountTool : NSObject

/**
 *  存储帐号
 */
+ (void)save:(JHAccount *)account;

/**
 *  读取帐号
 */
+ (JHAccount *)account;


@end
