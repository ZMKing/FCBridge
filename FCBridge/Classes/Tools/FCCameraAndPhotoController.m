//
//  CameraAndPhotoTool.m
//  sheet
//
//  Created by lyb on 16/3/22.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "FCCameraAndPhotoController.h"
#import "UIImage+FCExtension.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FCCameraAndPhotoController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, strong) UIView *selectV;

@end


@implementation FCCameraAndPhotoController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpImagePicker:self.type];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self addChildViewController:self.picker];
    self.picker.view.frame = self.view.bounds;
    [self.view addSubview:self.picker.view];
    [self.view layoutIfNeeded];
}

#pragma mark - imagePicker delegate
/**
 *  完成回调
 *
 *  @param picker imagePickerController
 *  @param info   信息字典
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
            });
        }
        
        //根据屏幕方向裁减图片(640, 480)||(480, 640),如不需要裁减请注释
        //image = [UIImage resizeImageWithOriginalImage:image];
        
        if (self.finishBack) {
            
            self.finishBack(image,nil);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //[picker dismissViewControllerAnimated:YES completion:nil];
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
    }
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {//可以在此解析错误
        
    }else{//保存成功
        
        //录制完之后自动播放
        if (self.finishBack) {
            
            self.finishBack(nil,videoPath);
        }
        
       [self.picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setUpImagePicker:(pickerType )type {
    
    self.picker = nil;
    
    self.picker = [[UIImagePickerController alloc] init];//初始化
    self.picker.delegate = self;
    self.picker.allowsEditing = NO;//设置不可编辑
    
    if (type == photoType) {
    
        //判断用户是否允许访问相册权限
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            
            return;
        }
         
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        self.picker.sourceType = sourceType;
    }else if (type == cameraType){
        //判断用户是否允许访问相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            NSLog(@"");
            //无权限
            return;
        }
        //判断用户是否允许访问相册权限
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限
            return;
        }
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.sourceType = sourceType;
        
        
    }else if (type == videoType) {
        //判断用户是否允许访问相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //无权限
            return;
        }
        
        //判断用户是否允许访问麦克风权限
        authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //无权限
            return;
        }

        //判断用户是否允许访问相册权限
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限
            return;
        }
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.sourceType = sourceType;
        
        self.picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        self.picker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
        self.picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
    }
    
}


- (void)dealloc{
    
    
    NSLog(@"============已经释放");
}

@end
