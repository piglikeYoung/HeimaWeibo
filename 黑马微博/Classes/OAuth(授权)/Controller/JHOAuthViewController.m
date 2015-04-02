//
//  HMOAuthViewController.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "JHOAuthViewController.h"
#import "MBProgressHUD+MJ.h"

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
//        [self accessTokenWithCode:code];
        JHLog(@"code=%@",code);
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    //处理操作....
}



@end
