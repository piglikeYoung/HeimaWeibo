//
//  NSString+File.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/16.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)

/**
 *  获取当前路径下的文件/文件夹里面的文件大小，使用了递归遍历
 */
- (long long)fileSize;
@end
