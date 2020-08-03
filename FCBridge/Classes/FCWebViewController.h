//
//  FCWebViewController.h
//  FCWebKit
//
//  Created by jinxiubo on 2018/4/28.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCWKWebView.h"
#import "WKWebViewExtension.h"
@class FCWebViewController;

#ifndef FC_REQUIRES_SUPER
#if __has_attribute(objc_requires_super)
#define FC_REQUIRES_SUPER __attribute__((objc_requires_super))
#else
#define FC_REQUIRES_SUPER
#endif
#endif

#pragma mark - MSWebViewControllerDelegate
@protocol FCWebViewControllerDelegate <NSObject>

@optional
- (void)webViewControllerWillGoBack:(FCWebViewController *)webViewController;
- (void)webViewControllerWillGoForward:(FCWebViewController *)webViewController;
- (void)webViewControllerWillReload:(FCWebViewController *)webViewController;
- (void)webViewControllerWillStop:(FCWebViewController *)webViewController;
- (void)webViewControllerDidStartLoad:(FCWebViewController *)webViewController;
- (void)webViewControllerDidFinishLoad:(FCWebViewController *)webViewController;
- (void)webViewController:(FCWebViewController *)webViewController didFailLoadWithError:(NSError *)error;

@end

#pragma mark - FCWebViewController

@interface FCWebViewController : UIViewController
@property (nonatomic, strong) FCWKWebView                      *webView;
@property (nonatomic, weak)   id<FCWebViewControllerDelegate>  delegate;
@property (nonatomic, strong) NSArray<NSHTTPCookie *>           *cookies;
@property (nonatomic, strong) UIColor                           *progressTintColor;
@property (nonatomic, copy) NSString                            *backImagePath;
@property (nonatomic, copy) NSString                            *closeImagePath;
@property (nonatomic, strong) UIBarButtonItem                   *backItem;
@property (nonatomic, strong) UIBarButtonItem                   *closeItem;
@property (nonatomic, copy) NSURLRequest                        *request;
@property (nonatomic, copy) NSString                            *htmlString;
@property (nonatomic, copy) NSURL                               *fileURL;
@property (nonatomic, assign) BOOL                              showProgressView;
@property (nonatomic, assign) BOOL                              needInterceptRequest;
@property (nonatomic, assign) BOOL                              allowsBFNavigationGesture;
@property (nonatomic, assign) BOOL                              isRootController;
@property (nonatomic, readonly, getter=canGoBack)    BOOL       canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL       canGoForward;
@property (nonatomic, readonly, getter=isLoading)    BOOL       loading;

//初始化方法栈
- (instancetype)initWithURLString:(NSString *)urlString;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithURLRequest:(NSMutableURLRequest *)request;
- (instancetype)initWithHTMLString:(NSString *)htmlString;
- (instancetype)initWithFileURL:(NSURL *)fileURL;

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadPostRequest:(NSURLRequest *)request;
- (void)updateNavigationTitle;
- (void)updateNavigationItems;

//当needInterceptRequest=YES时,该方法用于拦截请求
- (void)interceptRequestWithNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler;

//设置UserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type
                    customUserAgent:(NSString *)customUserAgent;

//注册拦截的scheme和class
- (void)registerSupportProtocolWithHTTP:(BOOL)supportHTTP
                                schemes:(NSArray<NSString *> *)schemes
                          protocolClass:(Class)protocolClass;

//注销拦截的scheme和class
- (void)unregisterSupportProtocolWithHTTP:(BOOL)supportHTTP
                                  schemes:(NSArray<NSString *> *)schemes
                            protocolClass:(Class)protocolClass;

//清除所有缓存
+ (void)clearAllWebCache;

@end

#pragma mark - FCWebViewController (SubclassHooks)
//以下方法供子类调用
@interface FCWebViewController (SubclassHooks)

//即将后退
- (void)willGoBack FC_REQUIRES_SUPER;

//即将前进
- (void)willGoForward FC_REQUIRES_SUPER;

//即将刷新
- (void)willReload FC_REQUIRES_SUPER;

//即将结束
- (void)willStop FC_REQUIRES_SUPER;

//开始加载
- (void)didStartLoad FC_REQUIRES_SUPER;

//已经加载完成
- (void)didFinishLoad FC_REQUIRES_SUPER;

//加载出错
- (void)didFailLoadWithError:(NSError *)error FC_REQUIRES_SUPER;

@end
