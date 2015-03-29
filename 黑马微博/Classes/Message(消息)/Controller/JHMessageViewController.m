//
//  JHMessageTableViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHMessageViewController.h"

@interface JHMessageViewController ()

@end

@implementation JHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //第二种方法
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"写消息" style:UIBarButtonItemStyleDone target:self action:nil];
    //设置为不可用状态
    self.navigationItem.rightBarButtonItem.enabled = NO;
}



@end
