//
//  MSWKWebView.m
//  FCWebKit
//
//  Created by jinxiubo on 2018/5/17.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import "FCWKWebView.h"
#import "WKCallNativeMethodMessageHandler.h"

@implementation FCWKWebView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
                configuration:(WKWebViewConfiguration *)configuration {
    if (self = [super initWithFrame:frame configuration:configuration]) {
        _recycleDate = NSDate.new;
        [self config];
    }
    return self;
}

#pragma mark - override
- (BOOL)canGoBack {
    if ([self.backForwardList.backItem.URL.absoluteString caseInsensitiveCompare:kWKWebViewReuseUrlString] == NSOrderedSame ||
        [self.URL.absoluteString isEqualToString:kWKWebViewReuseUrlString]) {
        return NO;
    }

    return [super canGoBack];
}

- (BOOL)canGoForward {
    if ([self.backForwardList.forwardItem.URL.absoluteString caseInsensitiveCompare:kWKWebViewReuseUrlString] == NSOrderedSame ||
        [self.URL.absoluteString isEqualToString:kWKWebViewReuseUrlString]) {
        return NO;
    }

    return [super canGoForward];
}


- (void)dealloc{
    //清除handler
    [self.configuration.userContentController removeScriptMessageHandlerForName:@"WKNativeMethodMessage"];

    //清除UserScript
    [self.configuration.userContentController removeAllUserScripts];

    //停止加载
    [self stopLoading];

    //清空Dispatcher
    [self unUseExternalNavigationDelegate];

    //清空相关delegate
    [super setUIDelegate:nil];
    [super setNavigationDelegate:nil];

    //持有者置为nil
    _holderObject = nil;

    NSLog(@"MSWKWebView dealloc");
}

#pragma mark - Configuration
- (void)config {
        self.backgroundColor = [UIColor clearColor];
        self.scrollView.backgroundColor = [UIColor clearColor];
}

#pragma mark - MSWKWebViewReuseProtocol
//即将被复用时
- (void)webViewWillReuse{
    _recycleDate = nil;
    [self useExternalNavigationDelegate];
}

//被回收
- (void)webViewEndReuse{
    _recycleDate = NSDate.new;
    _holderObject = nil;
    self.scrollView.delegate = nil;

    [self stopLoading];

    [self unUseExternalNavigationDelegate];

    [super setUIDelegate:nil];

    [super clearBrowseHistory];

    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kWKWebViewReuseUrlString]]];

    //删除所有的回调事件
    [self evaluateJavaScript:@"JSCallBackMethodManager.removeAllCallBacks();" completionHandler:^(id _Nullable data, NSError * _Nullable error) {

    }];
}

#pragma mark - public method
- (void)FC_loadRequestURLString:(NSString *)urlString {
    [self FC_loadRequestURL:[NSURL URLWithString:urlString]];
}

- (void)FC_loadRequestURL:(NSURL *)url {
    [self FC_loadRequestURL:url cookie:nil];
}

- (void)FC_loadRequestURL:(NSURL *)url cookie:(NSDictionary *)params {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    __block NSMutableString *cookieStr = [NSMutableString string];
    if (params) {
        [params enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull key, NSString* _Nonnull value, BOOL * _Nonnull stop) {
             [cookieStr appendString:[NSString stringWithFormat:@"%@ = %@;", key, value]];
        }];
    }

    if (cookieStr.length > 1)[cookieStr deleteCharactersInRange:NSMakeRange(cookieStr.length - 1, 1)];

    [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];

    [self FC_loadRequest:request.copy];
}

- (void)FC_loadRequest:(NSURLRequest *)requset {
    [super loadRequest:requset];
}

- (void)FC_loadHTMLTemplate:(NSString *)htmlTemplate {
    [super loadHTMLString:htmlTemplate baseURL:nil];
}

#pragma mark - Cache
+ (void)FC_clearAllWebCache {
    [super clearAllWebCache];
}

#pragma mark - UserAgent
- (void)FC_syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent {
    [super syncCustomUserAgentWithType:type customUserAgent:customUserAgent];
}

#pragma mark - register intercept protocol
+ (void)FC_registerProtocolWithHTTP:(BOOL)supportHTTP
                  customSchemeArray:(NSArray<NSString *> *)customSchemeArray
                   urlProtocolClass:(Class)urlProtocolClass {

    if (!urlProtocolClass) {
        return;
    }

    [NSURLProtocol registerClass:urlProtocolClass];
    [super registerSupportProtocolWithHTTP:supportHTTP customSchemeArray:customSchemeArray];
}

+ (void)FC_unregisterProtocolWithHTTP:(BOOL)supportHTTP
                    customSchemeArray:(NSArray<NSString *> *)customSchemeArray
                     urlProtocolClass:(Class)urlProtocolClass {

    if (!urlProtocolClass) {
        return;
    }

    [NSURLProtocol unregisterClass:urlProtocolClass];
    [super unregisterSupportProtocolWithHTTP:supportHTTP customSchemeArray:customSchemeArray];
}


+ (instancetype)webView {
    FCWKWebView *webView = [[FCWKWebView alloc] initWithFrame:CGRectZero
                                                  configuration:[self defaultConfiguration]];
    return webView;
}


+ (WKWebViewConfiguration *)defaultConfiguration {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];

    NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"FCJSResources" ofType:@"bundle"];

    NSString *scriptPath = [NSString stringWithFormat:@"%@/%@",bundlePath, @"FCJSBridge.js"];
    NSString *bridgeJSString = [[NSString alloc] initWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeJSString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];

    [configuration.userContentController addUserScript:userScript];
    [configuration.userContentController addScriptMessageHandler:[[WKCallNativeMethodMessageHandler alloc] init] name:@"WKNativeMethodMessage"];


    //3.视频播放相关

    if ([configuration respondsToSelector:@selector(setAllowsInlineMediaPlayback:)]) {
        [configuration setAllowsInlineMediaPlayback:YES];
    }

    //视频播放
    if (@available(iOS 10.0, *)) {
        if ([configuration respondsToSelector:@selector(setMediaTypesRequiringUserActionForPlayback:)]){
            [configuration setMediaTypesRequiringUserActionForPlayback:WKAudiovisualMediaTypeNone];
        }
    } else if (@available(iOS 9.0, *)) {
        if ([configuration respondsToSelector:@selector(setRequiresUserActionForMediaPlayback:)]) {
            [configuration setRequiresUserActionForMediaPlayback:NO];
        }
    } else {
        if ([configuration respondsToSelector:@selector(setMediaPlaybackRequiresUserAction:)]) {
            [configuration setMediaPlaybackRequiresUserAction:NO];
        }
    }

    return configuration;
}

@end
