//
//  store.m
//  LCWebView
//
//  Created by 李再民 on 2020/6/9.
//  Copyright © 2020 luochuan. All rights reserved.
//

#import "Service_storage.h"

@implementation Service_storage


- (void)func_writeNativeData:(NSDictionary *)param{

    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    
    @try {
        [save setObject:param[@"storageValue"] forKey:param[@"storageKey"]];
        [save synchronize];
    } @catch (NSException *exception) {
        
        void(^failCallback)(NSDictionary *result) = param[@"fail"];

        failCallback(@{@"info" : @"存入失败"});
    } @finally {
        
    }

    void(^successCallback)(NSDictionary *result) = param[@"success"];


    successCallback(@{@"msg" : @"存入成功",@"data":@{}});

}

- (void)func_readNativeData:(NSDictionary *)param{


    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    id data;
    @try {
        data = [save objectForKey:param[@"storageKey"]];
    }@catch (NSException *exception) {
        
        void(^failCallback)(NSDictionary *result) = param[@"fail"];

        failCallback(@{@"msg" : @"读取数据失败",@"data":@{}});
    } @finally {
        
    }
    if(data){
        void(^successCallback)(NSDictionary *result) = param[@"success"];

        successCallback(@{@"msg" :@"读取成功", @"data":data});
    }else{
        void(^failCallback)(NSDictionary *result) = param[@"fail"];

        failCallback(@{@"msg" : @"数据不存在",@"data":@{}});
    }
}

- (void)func_getAppInfo:(NSDictionary *)param{
    
    void(^successCallback)(NSDictionary *result) = param[@"success"];
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];

    successCallback(@{@"data" : @{
                              @"phoneVersion" : [[UIDevice currentDevice] systemVersion],
                              @"bundleId"     : [infoDictionary objectForKey:@"CFBundleIdentifier"],
                              @"buildVersion" : [infoDictionary objectForKey:@"CFBundleVersion"],
                              @"appVersion"   : [infoDictionary objectForKey:@"CFBundleShortVersionString"]
    }, @"msg":@"获取手机信息成功"});
}

- (void)func_removeItem:(NSDictionary *)param{
    
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    @try {
        [save removeObjectForKey:param[@"storageKey"]];
        [save synchronize];
    } @catch (NSException *exception) {
        
        void(^failCallback)(NSDictionary *result) = param[@"fail"];

        failCallback(@{@"msg" : @"删除失败"});
    } @finally {
        
    }
    
    void(^successCallback)(NSDictionary *result) = param[@"success"];
    successCallback(@{@"msg" : @"删除成功",@"data":@{}});
}

- (void)func_getUserInfo:(NSDictionary *)param{
    
    void(^successCallback)(NSDictionary *result) = param[@"success"];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"stuUserInfo"];
    //    NSDictionary *resultDict = @{
    //        @"id":@"1252844587228205056",
    //        @"subject":@"",
    //        @"disciplines":@"",
    //        @"sex":@"2",
    //        @"studenttel":@"18653009825",
    //        @"collegecode":@"",
    //        @"idcard":@"372922198603297894",
    //        @"majorid":@"",
    //        @"internationalcode":@"",
    //        @"password":@"",
    //        @"studentname":@"李再民",
    //        @"professionallevel":@"",
    //        @"personphone":@"",
    //        @"classid":@"",
    //        @"studentnum":@"",
    //        @"createdate":@"",
    //        @"photo" : @"http://dormitory.shuimuchangxiang.com:9000/group1/M00/00/00/wKgD-l6el7iAfQbyAAACPzUMOd8440.jpg",
    //    };

    successCallback(@{@"data" : dict,@"msg":@"获取用户数据成功"});
}
@end
