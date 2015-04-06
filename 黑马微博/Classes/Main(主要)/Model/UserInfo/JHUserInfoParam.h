//
//  JHUserInfoParam.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHBaseParam.h"

@interface JHUserInfoParam : JHBaseParam


/** false	int64	需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;

@end
