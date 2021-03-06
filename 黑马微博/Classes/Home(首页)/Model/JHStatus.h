//
//  JHStatus.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHUser;

@interface JHStatus : NSObject

/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/** 	string 	微博信息内容的富文本，从text转化而来*/
@property (nonatomic, copy) NSAttributedString *attributedText;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) JHUser *user;

/** 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细*/
@property (nonatomic, strong) JHStatus *retweeted_status;

/** 	int 	转发数*/
@property (nonatomic, assign) int reposts_count;

/** 	 int 	评论数*/
@property (nonatomic, assign) int comments_count;

/** 	 int 	表态数*/
@property (nonatomic, assign) int attitudes_count;

/** 	 object 	微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是HMPhoto模型*/
@property (nonatomic, strong) NSArray *pic_urls;

/** 	 BOOL 	是否转发微博*/
@property (nonatomic, assign, getter = isRetweeted) BOOL retweeted;

/** BOOL 是否展示JHStatusRetweetedToolbar工具条在转发微博下面 */
@property (nonatomic, assign, getter = isDetail) BOOL detail;
@end
