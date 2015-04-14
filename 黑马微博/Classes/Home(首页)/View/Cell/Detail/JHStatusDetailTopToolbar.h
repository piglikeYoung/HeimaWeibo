//
//  JHStatusDetailTopToolbar.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/14.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JHStatusDetailTopToolbarButtonTypeRetweeted,
    JHStatusDetailTopToolbarButtonTypeComment,
} JHStatusDetailTopToolbarButtonType;

@class JHStatusDetailTopToolbar, JHStatus;

@protocol JHStatusDetailTopToolbarDelegate <NSObject>

@optional
- (void)topToolbar:(JHStatusDetailTopToolbar *)topToolbar didSelectedButton:(JHStatusDetailTopToolbarButtonType)buttonType;

@end

@interface JHStatusDetailTopToolbar : UIView
+ (instancetype)toolbar;

@property (nonatomic, weak) id<JHStatusDetailTopToolbarDelegate> delegate;
@property (nonatomic, assign) JHStatus *status;
@end
