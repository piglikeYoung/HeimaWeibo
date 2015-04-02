//
//  HMOAuthViewController.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "JHOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "JHTabBarViewController.h"
#import "JHNewfeatureViewController.h"

@interface JHOAuthViewController () <UIWebViewDelegate>

@end

@implementation JHOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.加载登录页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1359433872&redirect_uri=http://ios.itcast.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 3.设置代理
    webView.delegate = self;
}


#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showMessage:@"正在加载中..."];
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *
 *  @param request        即将发送的请求
 
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获取请求地址
    NSString *url = request.URL.absoluteString;
    
    // 2.判断url是否为回调地址
    /**
     url = http://www.itheima.com/?code=a3db74011c311e629bafce3e50c25339
     range.location == 0
     range.length > 0
     */
    /**
     url =  https://api.weibo.com/oauth2/authorize
     range.location == NSNotFound
     range.length == 0
     */
    NSRange range = [url rangeOfString:@"http://ios.itcast.cn/?code="];
    if (range.location != NSNotFound) {
        
        // 截取授权成功后的请求标记
        int from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken(发送一个POST请求)
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1359433872";
    params[@"client_secret"] = @"37c372aa97a9329fc561947151c1bd38";
    params[@"redirect_uri"] = @"http://ios.itcast.cn";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    
    // 3.发送POST请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        JHLog(@"请求成功--%@", responseObject);
        
        // 存储授权成功的帐号信息
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [doc stringByAppendingPathComponent:@"account.plist"];
        [responseObject writeToFile:filePath atomically:YES];
        
        // 切换控制器，可能去新特性\tabbar
        NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
        
        // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults objectForKey:versionKey];
        
        // 获得当前打开软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([currentVersion isEqualToString:lastVersion]) {
            // 当前版本号 == 上次使用的版本：显示JHTabBarViewController
            window.rootViewController = [[JHTabBarViewController alloc] init];
        } else {
            // 当前版本号 != 上次使用的版本：显示版本新特性
            window.rootViewController = [[JHNewfeatureViewController alloc] init];
        
            // 存储这次使用的软件版本
            [defaults setObject:currentVersion forKey:versionKey];
            [defaults synchronize];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        JHLog(@"请求失败--%@", error);

    }];
}



@end
