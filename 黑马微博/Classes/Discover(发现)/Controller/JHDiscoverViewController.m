//
//  JHDiscoverViewController.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHDiscoverViewController.h"
#import "JHSearchBar.h"

@interface JHDiscoverViewController ()

@end

@implementation JHDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JHSearchBar *searchBar = [JHSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
        
    // 添加到导航栏中
    self.navigationItem.titleView = searchBar;
}



@end
