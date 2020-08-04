//
//  UIActionSheet+Block.h
//
//
//  Created by FCia on 15/10/27.
//  Copyright © 2015年 FCia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActionSheet (FCAlertAction)<UIActionSheetDelegate>


- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
