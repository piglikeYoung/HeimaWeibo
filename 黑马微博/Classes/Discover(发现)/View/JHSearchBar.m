//
//  JHSearchBar.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/30.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHSearchBar.h"

@implementation JHSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置背景图片
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        //    searchBar.textAlignment = NSTextAlignmentCenter;// 说明：这是设置文字水平居中
        // 设置文字内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // 设置左边的放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        self.leftView = leftView;
        // 设置leftView的frame
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        // 设置searchBar的leftViewMode为显示
        self.leftViewMode = UITextFieldViewModeAlways;
        // 设置放大镜左边的间距，设置leftView的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        
        // 设置右边永远显示清除按钮(马桶原理)
        self.clearButtonMode = UITextFieldViewModeAlways;

    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}


@end
