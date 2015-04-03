//
//  JHLoadMoreFooter.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHLoadMoreFooter : UIView

+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

@end
