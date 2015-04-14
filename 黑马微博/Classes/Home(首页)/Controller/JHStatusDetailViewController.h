//
//  JHStatusDetailViewController.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHStatus;

@interface JHStatusDetailViewController : UITableViewController
@property (nonatomic, strong) JHStatus *status;
@end
