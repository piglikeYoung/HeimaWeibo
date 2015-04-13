//
//  JHCommonViewController.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHCommonViewController : UITableViewController

// 暴露groups的get方法，.m文件里面做了实现
- (NSMutableArray *)groups;
@end
