//
//  JHTabBar.h
//  黑马微博
//
//  Created by piglikeyoung on 15/3/31.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTabBar;

@protocol JHTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(JHTabBar *)tabBar;

@end

@interface JHTabBar : UITabBar

@property (nonatomic, weak) id<JHTabBarDelegate> delegate;

@end
