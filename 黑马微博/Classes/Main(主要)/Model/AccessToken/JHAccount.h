//
//  JHAccount.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/2.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHAccount : NSObject <NSCoding>

/** string 	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/** string 	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** string 	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

@end
