//
//  JHPhoto.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHPhoto.h"

@implementation JHPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    // 新浪给的是缩略图路径，我们只需要更改缩略图路径中的thumbnail替换为bmiddle就是大图路径
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
