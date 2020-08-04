//
//  UIProgressView+WKWebView.h
//  FCWebKit
//
//  Created by jinxiubo on 2018/5/4.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCWebViewController;

@interface UIProgressView (WKWebView)

@property(nonatomic, assign) BOOL hiddenWhenWebDidLoad;

@property(nonatomic, strong) FCWebViewController *webViewController;

@end
