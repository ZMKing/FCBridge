//
//  Service_recorder.m
//  LCWebView
//
//  Created by 李再民 on 2020/6/11.
//  Copyright © 2020 luochuan. All rights reserved.
//

#import "Service_recorder.h"
#import <AVFoundation/AVFoundation.h>
#import "FCPermissionSetting.h"

@implementation Service_recorder


- (void)func_getRecorder:(NSDictionary *)param{
    
    // 判断有没有音频权限处理
    AVAudioSessionRecordPermission status = [AVAudioSession sharedInstance].recordPermission;
    // 没弹出授权
    if(status == AVAudioSessionRecordPermissionUndetermined){
        
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            
            if (granted) {
                
                // 授权成功
                NSLog(@"=========1=======已授权音频");
                
            }else{
                
                // 取消授权
                [self func_getRecorder:param];
            }
        }];

    // 已统一授权
    }else if (status == AVAudioSessionRecordPermissionGranted){
        
        
        NSLog(@"======2==========已授权音频");
    // 拒绝授权
    }else{
        
        [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有录音授权，是否前往设置" cancel:@"取消" setting:@"设置" ];
        
        return ;
        
    }
}


- (void)startAudio{
    
    
    
    
}







@end
