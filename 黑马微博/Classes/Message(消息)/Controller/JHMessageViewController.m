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
    
    
    //第一种方法，这种方法是有弊端的
    /*
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     [button setTitle:@"写私信" forState:UIControlStateNormal];
     [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
     [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
     button.titleLabel.font = [UIFont systemFontOfSize:15];
     // 设置按钮文字的尺寸 为 按钮自己的尺寸
     button.size = [button.currentTitle sizeWithFont:button.titleLabel.font];
     
     // 监听按钮点击
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
     self.navigationItem.rightBarButtonItem.enabled = NO;
     */
    
    //第二种方法
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"写消息" style:UIBarButtonItemStyleDone target:self action:nil];
    //设置为不可用状态
    self.navigationItem.rightBarButtonItem.enabled = NO;
}



@end
