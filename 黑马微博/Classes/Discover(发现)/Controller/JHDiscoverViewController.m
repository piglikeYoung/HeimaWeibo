//
//  JHDiscoverViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHDiscoverViewController.h"

@interface JHDiscoverViewController ()

@end

@implementation JHDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 第一种方案
    // 在导航栏按钮上，添加一个搜索框
    // 使用UISearchBar
    UISearchBar *bar = [[UISearchBar alloc] init];
    // 设置bar的frame
    bar.frame = CGRectMake(0, 0, 300, 35);
    self.navigationItem.titleView = bar;
    */
    
    
    /* 第二种方案
    // 在导航栏按钮上，添加一个搜索框
    // 使用UISearchBar
    UISearchBar *bar = [[UISearchBar alloc] init];
    // 设置bar的frame
    bar.frame = CGRectMake(0, 0, 300, 35);
    bar.backgroundImage = [UIImage resizedImage:@"searchbar_textfield_background"];
    self.navigationItem.titleView = bar;
     */
    
    UITextField *searchBar = [[UITextField alloc] init];
    // 设置frmae
    searchBar.width = 300;
    searchBar.height = 35;
    // 设置背景图片
    searchBar.background = [UIImage resizedImage:@"searchbar_textfield_background"];
//    searchBar.textAlignment = NSTextAlignmentCenter;// 说明：这是设置文字水平居中
    // 设置文字内容垂直居中
    searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 设置左边的放大镜
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
    searchBar.leftView = leftView;
    // 设置leftView的frame
    leftView.width = 40;
    leftView.height = searchBar.height;
    // 设置searchBar的leftViewMode为显示
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    // 设置放大镜左边的间距，设置leftView的内容居中
    leftView.contentMode = UIViewContentModeCenter;
    
    // 设置右边永远显示清除按钮(马桶原理)
    searchBar.clearButtonMode = UITextFieldViewModeAlways;
    
    // 添加到导航栏中
    self.navigationItem.titleView = searchBar;
}



@end
