//
//  HMOAuthViewController.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "JHOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JHControllerTool.h"
#import "JHAccount.h"
#import "JHAccountTool.h"
#import "JHHttpTool.h"

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
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", JHAppKey, JHRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
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
    NSString *str = [NSString stringWithFormat:@"%@/?code=",JHRedirectURI];
    NSRange range = [url rangeOfString:str];
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
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = JHAppKey;
    params[@"client_secret"] = JHAppSecret;
    params[@"redirect_uri"] = JHRedirectURI;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    
    // 3.发送POST请求
    [JHHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id responseObj) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        // 字典转成模型
        JHAccount *account = [JHAccount accountWithDict:responseObj];
        
        // 存储账号模型
        [JHAccountTool save:account];
        
        // 切换控制器(可能去新特性\tabbar)
        [JHControllerTool chooseRootViewController];
        
    } failure:^(NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        JHLog(@"请求失败--%@", error);

    }];
}



@end
