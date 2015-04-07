//
//  JHStatusCell.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/6.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHStatusFrame;

@interface JHStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

#warning 注意这里不能直接使用frame作为属性名。继承自UIview，而它本身就有一个frame
@property (nonatomic, strong) JHStatusFrame *statusFrame;

@end
