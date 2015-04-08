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
#import "NSDate+JH.h"

@implementation JHStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JHPhoto class]};
}

/**
 一、今年
 1、今天
 1分钟内：刚刚
 1个小时内：xx分钟前
 
 2、昨天
 昨天 xx:xx
 
 3、至少是前天发的
 04-23 xx:xx
 
 二、非今年
 2012-07-24
 */
// _created_at == Mon Jul 14 15:48:07 +0800 2014
// Mon Jul 14 15:48:07 +0800 2014 -> NSDate -> 2014-07-14 15:48:07
- (NSString *)created_at
{
    // 1.获得微博的创建时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // Tue May 31 17:46:55 +0800 2011
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 必须加上否则无法显示(说明时间格式所属的区域)
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // _created_at(NSString) -> createdTime(NSDate)
    // 将字符串(NSString)转成时间对象(NSDate), 方便进行日期处理
    NSDate *createdTime = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createdTime.isThisYear) {
        if (createdTime.isToday) { // 今天
            NSDateComponents *cmps = [createdTime deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%d小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%d分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createdTime.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdTime];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdTime];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createdTime];
    }
}

/**_source== <a href="http://app.weibo.com/t/feed/3j6BDx" rel="nofollow">M了个J</a>*/
//所需要的：M了个J
- (void)setSource:(NSString *)source
{
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@", subsource];
}

@end
