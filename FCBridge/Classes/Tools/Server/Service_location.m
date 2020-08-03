//
//  Service_location.m
//  LCWebView
//
//  Created by 李再民 on 2020/6/9.
//  Copyright © 2020 luochuan. All rights reserved.
//

#import "Service_location.h"
#import <CoreLocation/CLLocationManager.h>
#import "FCPermissionSetting.h"


@implementation Service_location


- (void)func_setLocationDescription:(NSDictionary *)param{
    
    // 定位权限的状态
    CLAuthorizationStatus staus = [CLLocationManager authorizationStatus];
    
    // 获取用户的申请定位权限
    NSString *type = param[@"type"];
    
    if(staus == kCLAuthorizationStatusDenied){
        
        
        [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"请前往设置授权定位" cancel:@"取消" setting:@"设置" ];
    }
    
    if ([type isEqualToString:@"when"]) {
        
        // 判断有没有申请定位
        if(staus != kCLAuthorizationStatusAuthorizedWhenInUse){
            
            [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"请前往设置定位权限" cancel:@"取消" setting:@"设置" ];
        
        }else{
 
            // 通知已申请
            void(^successCallback)(NSDictionary *result) = param[@"success"];
            successCallback(@{@"msg" : @"申请成功",@"data":@{}});
        }
        
    }else if ([type isEqualToString:@"always"]){
        
        // 判断有没有申请定位
        if(staus != kCLAuthorizationStatusAuthorizedAlways){
        
            [FCPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"请前往设置定位权限" cancel:@"取消" setting:@"设置" ];
           
        }else{

           // 通知已申请
           void(^successCallback)(NSDictionary *result) = param[@"success"];
           successCallback(@{@"msg" : @"申请成功",@"data":@{}});
        }
    }
}

- (void)func_getLocationDescription:(NSDictionary *)param{

    CLAuthorizationStatus staus = [CLLocationManager authorizationStatus];
    
    if(staus == kCLAuthorizationStatusNotDetermined){
        
        // 通知已申请
        void(^failCallback)(NSDictionary *result) = param[@"fail"];
        failCallback(@{@"msg" : @"用户未通过定位权限申请",@"data":@{}});
    }else if(staus == kCLAuthorizationStatusDenied){
        
        // 通知已申请
        void(^failCallback)(NSDictionary *result) = param[@"fail"];
        failCallback(@{@"msg" : @"用户拒绝定位权限申请",@"data":@{}});
    }else if(staus == kCLAuthorizationStatusRestricted){
        
        // 通知已申请
        void(^failCallback)(NSDictionary *result) = param[@"fail"];
        failCallback(@{@"msg" : @"未通过定位权限",@"data":@{}});
    }else if(staus == kCLAuthorizationStatusAuthorizedWhenInUse ){
     
        void(^successCallback)(NSDictionary *result) = param[@"success"];
        successCallback(@{@"msg" : @"申请成功",@"data":@{@"status":@"when"}});
        
    }else if (staus == kCLAuthorizationStatusAuthorizedAlways){
        
        void(^successCallback)(NSDictionary *result) = param[@"success"];
        successCallback(@{@"msg" : @"申请成功",@"data":@{@"status":@"always"}});
    }
}




@end
