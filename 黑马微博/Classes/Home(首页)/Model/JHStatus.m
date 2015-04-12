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
#import "RegexKitLite.h"
#import "JHRegexResult.h"
#import "JHEmotionAttachment.h"
#import "JHEmotionTool.h"
#import "JHUser.h"

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


- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
}

- (void)setUser:(JHUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeted_status:(JHStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    // 本身是原创
    self.retweeted = NO;
    // 转发内容是转发微博
    retweeted_status.retweeted = YES;
}

- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    [self createAttributedText];
}


/**
 *  判断微博类型
 *  是转发微博，微博内容前面有用户名
 *  是原创微博，只有微博内容
 *
 */
- (void)createAttributedText
{
    // text和user的set方法不确定谁先调用
    // 只有text和user有值后，才设置微博内容
    if (self.text == nil || self.user == nil) return;
    
    // 是转发微博
    if (self.retweeted) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ : %@", self.user.name, self.text];
        NSAttributedString *attributedString = [self attributedStringWithText:totalText];
        self.attributedText = attributedString;
    } else {// 原创微博
        
        self.attributedText = [self attributedStringWithText:self.text];
    }
}

/**
 *  把匹配结果重新拼接成富文本字符串
 *
 *  @param text 富文本字符串
 */
- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    // 链接、@提到、#话题#
    
    // 1.匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 2.根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(JHRegexResult *result, NSUInteger idx, BOOL *stop) {
        
        JHEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [JHEmotionTool emotionWithDesc:result.string];
        }
        
        if (emotion) { // 如果有表情
            // 创建附件对象
            JHEmotionAttachment *attach = [[JHEmotionAttachment alloc] init];
            
            // 传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, JHStatusOrginalTextFont.lineHeight, JHStatusOrginalTextFont.lineHeight);
            
            // 将附件转成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:JHStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:JHStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:JHStatusHighTextColor range:*capturedRanges];
            }];
            
            [attributedString appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:JHStatusRichTextFont range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}


/**
 *  根据字符串计算出所有的匹配结果（已经排好序）
 *
 *  @param text 字符串内容
 */
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JHRegexResult *rr = [[JHRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JHRegexResult *rr = [[JHRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];
    }];
    
    
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(JHRegexResult *rr1, JHRegexResult *rr2) {
        int loc1 = rr1.range.location;
        int loc2 = rr2.range.location;
        return [@(loc1) compare:@(loc2)];
//        if (loc1 < loc2) {
//            return NSOrderedAscending; // 升序（右边越来越大）
//        } else if (loc1 > loc2) {
//            return NSOrderedDescending; // 降序（右边越来越小）
//        } else {
//            return NSOrderedSame;
//        }

    }];
    
    return regexResults;
    
}

@end
