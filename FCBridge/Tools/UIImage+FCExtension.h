//
//  UIImage+Extension.h
//  chebanlv-standard
//
//  Created by lyb on 16/3/22.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


+ (instancetype)fc_imageRendOriginalWithImageName:(NSString *)imageName;

/**
 *  取消系统对图片的渲染
 *
 *  @param imageName 图片
 *
 *  @return 原始无渲染图片
 */
+ (UIImage *)fc_imageModeAlwaysOriginal:(NSString *)imageName;
/**
 *  重新设置图片尺寸
 *
 *  @param name 图片名称
 *  @param size 新尺寸
 *
 *  @return 图片
 */
+ (UIImage *)fc_imageResizableWithImage:(NSString *)name size:(CGFloat)size;
/**
 *  取消系统对图片的渲染并且重设尺寸
 *
 *  @param imageName 图片名称
 *  @param size      新的尺寸
 *
 *  @return 新的图片
 */
+ (UIImage *)fc_imageModeAlwaysOriginalWithResizableImage:(NSString *)imageName size:(CGFloat)size;
/**
 *  通过颜色创建图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)fc_imageCreateImageWithColor:(UIColor *)color;
/**
 *  压缩原图片尺寸
 *
 *  @param image 原图片
 *  @param size  新尺寸
 *
 *  @return 新图片
 */
-(UIImage*)fc_imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  设置图片拉伸位置
 *
 *  @param image        原始图片
 *  @param leftCapWidth 左端盖宽度
 *  @param topCapHeight 顶端盖宽度
 *
 *  @return 新图片
 */
+ (UIImage *)fc_imageWithImage:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth andTopCapHeight:(NSInteger)topCapHeight;

/**
 *  设置图片只拉伸中间区域
 *
 *  @param imageName 原始图片名称
 *
 *  @return 新图片
 */
+ (UIImage *)fc_getImageWithImageName:(NSString *)imageName;
/**
 *  获取压缩图片 图片尺寸压缩至640*480 或者 480*640
 *
 *  @param image 原始图片
 *
 *  @return 新的图片
 */
+ (UIImage *)fc_resizeImageWithOriginalImage:(UIImage *)image;
@end
