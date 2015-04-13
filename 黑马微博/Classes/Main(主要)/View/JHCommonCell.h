//
//  JHCommonCell.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHCommonItem;

@interface JHCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** cell对应的item数据 */
@property (nonatomic, strong) JHCommonItem *item;
@end
