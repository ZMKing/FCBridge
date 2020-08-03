//
//  MSWKWebView.h
//  FCWebKit
//
//  Created by jinxiubo on 2018/5/17.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WKWebViewExtension.h"
#import "FCWKWebViewPool.h"

@interface FCWKWebView : WKWebView<FCWKWebViewReuseProtocol>

@property (nonatomic, weak, readwrite) id holderObject;
@property (nonatomic, strong, readonly) NSDate *recycleDate;

+ (instancetype)webView;

+ (WKWebViewConfiguration *)defaultConfiguration;

#pragma mark - load request
- (void)FC_loadRequestURLString:(NSString *)urlString;

- (void)FC_loadRequestURL:(NSURL *)url;

- (void)FC_loadRequestURL:(NSURL *)url cookie:(NSDictionary *)params;

- (void)FC_loadRequest:(NSURLRequest *)requset;

- (void)FC_loadHTMLTemplate:(NSString *)htmlTemplate;

#pragma mark - Cache
+ (void)FC_clearAllWebCache;

#pragma mark - UserAgent
- (void)FC_syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent;

#pragma mark - register intercept protocol
+ (void)FC_registerProtocolWithHTTP:(BOOL)supportHTTP
               customSchemeArray:(NSArray<NSString *> *)customSchemeArray
                urlProtocolClass:(Class)urlProtocolClass;

+ (void)FC_unregisterProtocolWithHTTP:(BOOL)supportHTTP
                  customSchemeArray:(NSArray<NSString *> *)customSchemeArray
                   urlProtocolClass:(Class)urlProtocolClass;

@end
