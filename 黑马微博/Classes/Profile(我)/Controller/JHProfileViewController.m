//
//  JHProfileViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHProfileViewController.h"
#import "JHPopMenu.h"

@interface JHProfileViewController ()

@end

@implementation JHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
}

- (void) setting
{
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor redColor];
    
    JHPopMenu *menu = [JHPopMenu popMenuWithContentView:tableView];
    CGFloat menuW = 100;
    CGFloat menuH = 200;
    CGFloat menuY = 55;
    CGFloat menuX = self.view.width - menuW - 20;
    menu.dimBackground = YES;
    menu.arrowPosition = JHPopMenuArrowPositionRight;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}


@end
