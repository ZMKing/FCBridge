//
//  UIAlertView+Block.h
//
//
//  Created by FCia on 15/10/27.
//  Copyright © 2015年 FCia. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIAlertView (FCAlertAction)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showWithBlock:(void(^)(NSInteger buttonIndex)) block;




@end
