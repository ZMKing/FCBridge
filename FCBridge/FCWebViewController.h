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
@property (nonatomic, strong) FCWKWebView                      *webView;           //当前Web控件
@property (nonatomic, weak)   id<FCWebViewControllerDelegate>  delegate;           //代理对象
@property (nonatomic, strong) NSArray<NSHTTPCookie *>           *cookies;           //设置cookie
@property (nonatomic, copy) NSString                            *backImagePath;     //返回按钮图片的路径(默认为当前库的资源bundle)
@property (nonatomic, copy) NSString                            *closeImagePath;    //关闭按钮图片的路径(默认为当前库的资源bundle)
@property (nonatomic, assign) BOOL                              showProgressView;   //是否展示进度条(默认YES)
@property (nonatomic, strong) UIColor                           *progressTintColor; //进度条颜色
@property (nonatomic, assign) NSTimeInterval                    timeoutInternal;    //超时时间(默认15)
@property (nonatomic, assign) NSURLRequestCachePolicy           cachePolicy;        //Web缓存模式
@property (nonatomic, readonly, getter=canGoBack) BOOL          canGoBack;          //是否可以goback
@property (nonatomic, readonly, getter=canGoForward) BOOL       canGoForward;       //是否可以goforward
@property (nonatomic, readonly, getter=isLoading) BOOL          loading;            //Web是否正在加载中
@property (nonatomic, assign) BOOL                              allowsBFNavigationGesture;//是否开启往返手势(默认YES)

/**
 是否需要拦截请求,默认NO,如果设置为YES,则会将请求cancel,然后调用interceptRequestWithNavigationAction:方法
 
 如果有以下场景请将该属性设置为YES
 - 给url追加参数
 */
@property(nonatomic, assign) BOOL                           needInterceptRequest;

//初始化方法栈
- (instancetype)initWithURLString:(NSString *)urlString;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithURLRequest:(NSMutableURLRequest *)request;

//更新items
- (void)updateNavigationItems;

//设置UserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent;

//注册拦截的scheme和class
- (void)registerSupportProtocolWithHTTP:(BOOL)supportHTTP
                                schemes:(NSArray<NSString *> *)schemes
                          protocolClass:(Class)protocolClass;

//注销拦截的scheme和class
- (void)unregisterSupportProtocolWithHTTP:(BOOL)supportHTTP
                                  schemes:(NSArray<NSString *> *)schemes
                            protocolClass:(Class)protocolClass;

//直接加载html内容
- (void)loadHTMLTemplate:(NSString *)htmlTemplate;

//清除所有缓存
+ (void)clearAllWebCache;

@end

#pragma mark - FCWebViewController (SubclassHooks)
//以下方法供子类调用
@interface FCWebViewController (SubclassHooks)

/**
 如果needInterceptReq设置为YES,会调用该方法,为了保证流程可以正常执行,当needInterceptReq设置为YES时子类务必重写该方法
 
 @param navigationAction 通过该参数可以获取request和url,可以自行设置cookie或给url追加参数,然后让webView重新loadRequest
 */
- (void)interceptRequestWithNavigationAction:(WKNavigationAction *)navigationAction
                             decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

/*
 注意:子类调用以下方法需要在方法实现中调用super
 */

/**
 即将后退
 */
- (void)willGoBack FC_REQUIRES_SUPER;

/**
 即将前进
 */
- (void)willGoForward FC_REQUIRES_SUPER;

/**
 即将刷新
 */
- (void)willReload FC_REQUIRES_SUPER;

/**
 即将结束
 */
- (void)willStop FC_REQUIRES_SUPER;

/**
 开始加载
 */
- (void)didStartLoad FC_REQUIRES_SUPER;

/**
 已经加载完成
 */
- (void)didFinishLoad FC_REQUIRES_SUPER;

/**
 加载出错
 */
- (void)didFailLoadWithError:(NSError *)error FC_REQUIRES_SUPER;

@end
