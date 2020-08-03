//
//  CameraAndPhotoTool.h
//  sheet
//
//  Created by lyb on 16/3/22.
//  Copyright © 2016年 lyb. All rights reserved.
//  调用系统相机和相册的工具类

#import <UIKit/UIKit.h>
typedef enum {
    
    photoType,
    cameraType,
    videoType,
    all
}pickerType;

@interface FCCameraAndPhotoController : UIViewController

@property (nonatomic, copy) void(^finishBack)(UIImage *image,NSString *videoPath);

@property (nonatomic, assign) pickerType type;


@end
