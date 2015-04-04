//
//  HMComposeViewController.m
//  黑马微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "JHComposeViewController.h"
#import "JHTextView.h"
#import "JHComposeToolbar.h"

@interface JHComposeViewController () <JHComposeToolbarDelegate, UITextViewDelegate>

@property (nonatomic, weak) JHTextView *textView;
@property (nonatomic, weak) JHComposeToolbar *toolbar;

@end

@implementation JHComposeViewController

#pragma mark - 初始化方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];

}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    JHComposeToolbar *toolbar = [[JHComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    JHTextView *textView = [[JHTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.delegate = self;
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 设置导航条内容
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 私有方法
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    JHLog(@"send");
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}


/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        // 键盘的高度就是toolbar向上移动的高度
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];

}


#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(JHComposeToolbar *)toolbar didClickedButton:(JHComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case JHComposeToolbarButtonTypeCamera: // 照相机
            JHLog(@"打开照相机");
            break;
            
        case JHComposeToolbarButtonTypePicture: // 相册
            JHLog(@"打开相册");
            break;
            
        case JHComposeToolbarButtonTypeEmotion: // 表情
            JHLog(@"打开表情");
            break;
            
        default:
            break;
    }

}

@end
