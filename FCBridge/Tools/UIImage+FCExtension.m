//
//  UIImage+Extension.m
//  chebanlv-standard
//
//  Created by lyb on 16/3/22.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "UIImage+FCExtension.h"

@implementation UIImage (Extension)


+ (instancetype)fc_imageRendOriginalWithImageName:(NSString *)imageName;{
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)fc_imageModeAlwaysOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)fc_imageResizableWithImage:(NSString *)name size:(CGFloat)size {
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * size;
    CGFloat h = normal.size.height * size;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)fc_imageModeAlwaysOriginalWithResizableImage:(NSString *)imageName size:(CGFloat)size {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGFloat w = image.size.width * size;
    CGFloat h = image.size.height * size;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)fc_imageCreateImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
-(UIImage*)fc_imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (UIImage *)fc_imageWithImage:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth andTopCapHeight:(NSInteger)topCapHeight{

    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    return image;
}

+ (UIImage *)fc_getImageWithImageName:(NSString *)imageName{

    UIImage *normalImage = [UIImage imageNamed:imageName];
   
    normalImage = [normalImage stretchableImageWithLeftCapWidth:55 topCapHeight:17];
    
    return normalImage;
}

+ (UIImage *)fc_resizeImageWithOriginalImage:(UIImage *)image
{

    if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown) {
        
        image = [self fc_imageCompressForOriginalImage:image targetSize:CGSizeMake(480, 640)];
        
    }else if (image.imageOrientation == UIImageOrientationLeft || image.imageOrientation == UIImageOrientationRight){
        
        image = [self fc_imageCompressForOriginalImage:image targetSize:CGSizeMake(640, 480)];
    }
    
    return image;
}

+ (UIImage *) fc_imageCompressForOriginalImage:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
//    if(newImage == nil){
//        ZLog(@"scale image fail");
//    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
