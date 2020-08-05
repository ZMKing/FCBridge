//
//  Service_push.m
//  LCWebView
//
//  Created by 李再民 on 2020/5/26.
//  Copyright © 2020 luochuan. All rights reserved.
//

#import "Service_camera.h"

#import "FCPermissionSetting.h"
#import "FCAlertAction.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "FCCameraAndPhotoController.h"

#import <Photos/PHPhotoLibrary.h>
#import "FCScanViewController.h"

@interface Service_camera()

@property (nonatomic, strong) NSDictionary *param;
@end


@implementation Service_camera


- (void)func_getQrCode:(NSDictionary *)param{

    if (@available(iOS 10.0, *)) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        {
            [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
            return;
        }
    }
        
    FCScanViewController * vc = [[FCScanViewController alloc] init];
    
    vc.returnScanBarCodeValue = ^(NSString * barCodeString){
      
        if (barCodeString.length > 0) {
            
            void(^successCallback)(NSDictionary *result) = param[@"success"];

            NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"qrcode":barCodeString}};

            successCallback(resultDict);
        }else{

            void(^failCallback)(NSDictionary *result) = param[@"fail"];

            NSDictionary *resultDict = @{@"msg":@"读取失败",@"data":@{@"qrcode":@""}};

            failCallback(resultDict);
        }
    };
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

- (void)func_getBarCode:(NSDictionary *)param{

    if (@available(iOS 10.0, *)) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        {
            [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
            return;
        }
    }
    
    FCScanViewController * vc = [[FCScanViewController alloc] init];
    
    vc.returnScanBarCodeValue = ^(NSString * barCodeString){
      
        if (barCodeString.length > 0) {
            
            void(^successCallback)(NSDictionary *result) = param[@"success"];

            NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"barcode":barCodeString}};

            successCallback(resultDict);
        }else{

            void(^failCallback)(NSDictionary *result) = param[@"fail"];

            NSDictionary *resultDict = @{@"msg":@"读取失败",@"data":@{@"barcode":@""}};

            failCallback(resultDict);
        }
    };
    
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}


- (void)func_getPhotoImg:(NSDictionary *)param{

     FCCameraAndPhotoController *vdC = [[FCCameraAndPhotoController alloc] init];
     if ([param[@"type"] isEqualToString:@"photoType"]) {
          
         vdC.type = photoType;
         
         if (@available(iOS 10.0, *)) {
             
             PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
             if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
             {
                  [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
                 
                 return ;
             }
         }
         vdC.modalPresentationStyle = UIModalPresentationFullScreen;
         [vdC setFinishBack:^(UIImage *image, NSString *videoPath) {
              
              NSData *imgData = UIImageJPEGRepresentation(image, 0.001);
              NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
              void(^successCallback)(NSDictionary *result) = param[@"success"];
          
             NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"base64ImgStr":encodedImageStr}};
          
              successCallback(resultDict);
          }];
          [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vdC animated:YES completion:nil];

     }else if([param[@"type"] isEqualToString:@"cameraType"]){
         
         vdC.type = cameraType;
         
         if (@available(iOS 10.0, *)) {
             AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
             if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
             {
                 [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
                 return;
             }
         }
         vdC.modalPresentationStyle = UIModalPresentationFullScreen;
         [vdC setFinishBack:^(UIImage *image, NSString *videoPath) {
              
              NSData *imgData = UIImageJPEGRepresentation(image, 0.001);
              NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
              void(^successCallback)(NSDictionary *result) = param[@"success"];
          
              NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"base64ImgStr":encodedImageStr}};
          
              successCallback(resultDict);
          }];
          [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vdC animated:YES completion:nil];
     }else if([param[@"type"] isEqualToString:@"all"]){
        
         if (@available(iOS 10.0, *)) {
             AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
             if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
             {
                 [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
                 return;
             }
         }
         
         if (@available(iOS 10.0, *)) {
             
             PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
             if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
             {
                  [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置" ];
                 
                 return ;
             }
         }
         
         // 拉起选项
         //1.创建Controller
         UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取方式" preferredStyle:UIAlertControllerStyleActionSheet];
         /*
          参数说明：
          Title:弹框的标题
          message:弹框的消息内容
          preferredStyle:弹框样式：UIAlertControllerStyleActionSheet
          */

         //2.添加按钮动作
         UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             FCCameraAndPhotoController *vdC = [[FCCameraAndPhotoController alloc] init];
             vdC.type = cameraType;
             vdC.modalPresentationStyle = UIModalPresentationFullScreen;
             [vdC setFinishBack:^(UIImage *image, NSString *videoPath) {
                  
                  NSData *imgData = UIImageJPEGRepresentation(image, 0.001);
                  NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
                  void(^successCallback)(NSDictionary *result) = param[@"success"];
              
                  NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"base64ImgStr":encodedImageStr}};
              
                  successCallback(resultDict);
              }];
              [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vdC animated:YES completion:nil];
         }];
         UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             FCCameraAndPhotoController *vdC = [[FCCameraAndPhotoController alloc] init];
             vdC.type = photoType;
             vdC.modalPresentationStyle = UIModalPresentationFullScreen;
             [vdC setFinishBack:^(UIImage *image, NSString *videoPath) {
                  
              
                  NSData *imgData = UIImageJPEGRepresentation(image, 0.001);
                  NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
                  void(^successCallback)(NSDictionary *result) = param[@"success"];
              
                  NSDictionary *resultDict = @{@"msg":@"读取成功",@"data":@{@"base64ImgStr":encodedImageStr}};
              
                  successCallback(resultDict);
              }];
              [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vdC animated:YES completion:nil];
         }];
         UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

             [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
         }];
         //3.添加动作
         [alertSheet addAction:action1];
         [alertSheet addAction:action2];
         [alertSheet addAction:cancel];

         //4.显示sheet
         [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertSheet animated:YES completion:nil];
         
     }else{
         void(^failCallback)(NSDictionary *result) = param[@"fail"];
     
         NSDictionary *resultDict = @{@"msg":@"填写对应的type值字段",@"data":@{}};
     
         failCallback(resultDict);
         return;
     }
      
}



    






@end
