//
//  JXPRequestUtil.m
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPRequestUtil.h"

#import "JXPHTTPClient.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import <SystemConfiguration/CaptiveNetwork.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//引入IOS自带密码库
#include <CommonCrypto/CommonCryptor.h>

@interface JXPRequestUtil()<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *receiveData;//异步请求接受数据
@property (nonatomic, strong) UIProgressView *progressView;
/**
 *  统一解析返回状态为请求成功还是请求失败
 */
+ (void)checkResponseObject:(id)responseObject success:(RequestSuccess)success failure:(RequestFailure)failure;

@end

@implementation JXPRequestUtil

//通过action参数 来判断请求类型

/**
 *  @params muuid:手机唯一标示
 *  @params clientType:3
 *  @params terminalTypeId:（应用app  TERMINALTYPE）
 *  @params roleId:（费率版2、封顶版3 全版1）
 */

+ (NSMutableDictionary *)initDic {
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:[NSString newUUID] forKey:@"muuid"];
    [para setObject:@"3" forKey:@"clientType"];
    [para setObject:@"10" forKey:@"terminalTypeId"];
    [para setObject:@"1" forKey:@"roleId"];
    return para;
}

+ (NSMutableDictionary *)initDicWithRoleId:(NSString *)roleId {
    NSLog(@"###roleId == %@", roleId);
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"3" forKey:@"clientType"];
    [para setObject:@"10" forKey:@"terminalTypeId"];
    [para setObject:roleId forKey:@"roleId"];
    
    return para;
}


#pragma mark - Account
+ (void)userActionLoginWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{
    
    DDLogInfo(@"userActionLoginWithParams : %@",params);
    NSMutableDictionary *dic = [JXPRequestUtil initDic];
    [dic addEntriesFromDictionary:params];
    [[JXPHTTPClient sharedInstance] POST:PORTSTR parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        DDLogInfo(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogInfo(@"userActionLoginWithParams data:%@", responseObject);
        [self checkResponseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogError(@"userActionLoginWithParams error:%@",error);
        BLOCK(failure)([self showErrorReasonWith:error]);
    }];
}

+ (void)userActionRegisterWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{

    DDLogInfo(@"userActionRegisterWithParams : %@",params);
    NSMutableDictionary *dic = [JXPRequestUtil initDic];
    [dic addEntriesFromDictionary:params];
    [[JXPHTTPClient sharedInstance] POST:PORTSTR parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        DDLogInfo(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogInfo(@"userActionRegisterWithParams data:%@", responseObject);
        [self checkResponseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogError(@"userActionRegisterWithParams error:%@",error);
        BLOCK(failure)([self showErrorReasonWith:error]);
    }];
}



#pragma mark - Business
+ (void)userActionGetBusinessRangeListWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{
    
    DDLogInfo(@"userActionGetBusinessRangeListWithParams : %@",params);
    NSMutableDictionary *dic = [JXPRequestUtil initDic];
    [dic addEntriesFromDictionary:params];
    [[JXPHTTPClient sharedInstance] POST:PORTSTR parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        DDLogInfo(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogInfo(@"userActionGetBusinessRangeListWithParams data:%@", responseObject);
        [self checkResponseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogError(@"userActionGetBusinessRangeListWithParams error:%@",error);
        BLOCK(failure)([self showErrorReasonWith:error]);
    }];
}













#pragma mark - Cancel request
//取消当前所以请求
+ (void)cancelAllRequest{
    
    [[JXPHTTPClient sharedInstance].operationQueue cancelAllOperations];
    
    /**
     
     NSURL *URL = [NSURL URLWithString:@http];
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     NSURLSessionDataTask *task = [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
     
     DDLogInfo(@"JSON: %@", responseObject);
     
     } failure:^(NSURLSessionTask *operation, NSError *error) {
     
     DDLogInfo(@"Error: %@", error);
     
     }];
     
     //取消单个请求
     
     [task cancel];
     
     //取消当前所有
     
     [manager.operationQueue cancelAllOperations];
     
     */
}

#pragma mark - Other



//获取当前手机连接的wifi信息
+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            DDLogInfo(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    wifiName = [JXPRequestUtil checkWiFiMacAddressWithOldMac:wifiName];
    return wifiName;
}

+ (NSString *)getWifiSSID
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            DDLogInfo(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
}

//BSSID = "d8:15:0d:0e:74:7c";  cp
//BSSID = "d8:15:d:e:82:6e";    yw
+ (NSString *)checkWiFiMacAddressWithOldMac:(NSString *)oldMac{
    
    NSString * changeStr = nil;
    NSMutableArray *newsArray = [[NSMutableArray alloc] init];
    NSArray *oldArray = [oldMac componentsSeparatedByString:@":"];
    for (NSString *str in oldArray) {
        
        if (str.length == 1) {
            
            changeStr = [NSString stringWithFormat:@"%@%@",@"0",str];
        }else{
            
            changeStr = str;
        }
        [newsArray addObject:changeStr];
    }
    return [newsArray componentsJoinedByString:@":"];
}

#pragma mark - 显示错误原因

+ (NSString *)showErrorReasonWith:(NSError *)error {
    
    /*
     NSURLErrorUnknown = 			-1,
     NSURLErrorCancelled = 			-999,
     NSURLErrorBadURL = 				-1000,
     NSURLErrorTimedOut = 			-1001,
     NSURLErrorUnsupportedURL = 			-1002,
     NSURLErrorCannotFindHost = 			-1003,
     NSURLErrorCannotConnectToHost = 		-1004,
     NSURLErrorNetworkConnectionLost = 		-1005,
     NSURLErrorDNSLookupFailed = 		-1006,
     NSURLErrorHTTPTooManyRedirects = 		-1007,
     NSURLErrorResourceUnavailable = 		-1008,
     NSURLErrorNotConnectedToInternet = 		-1009,
     NSURLErrorRedirectToNonExistentLocation = 	-1010,
     NSURLErrorBadServerResponse = 		-1011,
     NSURLErrorUserCancelledAuthentication = 	-1012,
     NSURLErrorUserAuthenticationRequired = 	-1013,
     NSURLErrorZeroByteResource = 		-1014,
     NSURLErrorCannotDecodeRawData =             -1015,
     NSURLErrorCannotDecodeContentData =         -1016,
     NSURLErrorCannotParseResponse =             -1017,
     NSURLErrorAppTransportSecurityRequiresSecureConnection NS_ENUM_AVAILABLE(10_11, 9_0) = -1022,
     NSURLErrorFileDoesNotExist = 		-1100,
     NSURLErrorFileIsDirectory = 		-1101,
     NSURLErrorNoPermissionsToReadFile = 	-1102,
     NSURLErrorDataLengthExceedsMaximum NS_ENUM_AVAILABLE(10_5, 2_0) =	-1103,
     
     // SSL errors
     NSURLErrorSecureConnectionFailed = 		-1200,
     NSURLErrorServerCertificateHasBadDate = 	-1201,
     NSURLErrorServerCertificateUntrusted = 	-1202,
     NSURLErrorServerCertificateHasUnknownRoot = -1203,
     NSURLErrorServerCertificateNotYetValid = 	-1204,
     NSURLErrorClientCertificateRejected = 	-1205,
     NSURLErrorClientCertificateRequired =	-1206,
     NSURLErrorCannotLoadFromNetwork = 		-2000,
     */
    if([error code] == NSURLErrorTimedOut){//-1001
        
        return @"网络连接超时!";
    }
    if([error code] == NSURLErrorCancelled){//-999
        
        return @"网络连接取消!";
    }
    if([error code] == NSURLErrorBadURL){//-1000
        
        return @"网络链接失效!";
    }
    if([error code] == NSURLErrorUnsupportedURL){//-1002
        
        return @"不支持的链接!";
    }
    if([error code] == NSURLErrorCannotConnectToHost){//-999
        
        return @"无法连接到服务器!";
    }
    if([error code] == NSURLErrorNetworkConnectionLost){//-999
        
        return @"无法找到网络!";
    }
    if ([error code] == NSURLErrorCannotFindHost) {//-1003
        return @"未能找到服务器,连接失败!";
    }
    if ([error code] == NSURLErrorNotConnectedToInternet) {//-1009
        return @"未能连接到网络,请重启网络!";
    }
    if([[error localizedDescription] isEqualToString:@"The request timed out."] ||
       [error code] == NSURLErrorTimedOut){//-1001
        
        return @"网络连接超时!";
    }else if([[error localizedDescription] isEqualToString:@"The Internet connection appears to be offline."]){
        
        return @"请检查网络是否连接?";
    }else if([[error localizedDescription] isEqualToString:@"Could not connect to the server."]){
        
        return @"不能连接服务器,请检查网络!";
    }else if([[error localizedDescription] isEqualToString:@"Request failed: unacceptable content-type: text/html"] ||
             [error code] == NSURLErrorUnknown){//-1
        
        return @"未知错误!";//未知错误
    }else if([[error localizedDescription] isEqualToString:@"Request failed: internal server error (500)"]){
        
        return @"服务器异常!";
    }
    else if([[error localizedDescription] isEqualToString:@"Request too large (413)"]){
        
        return @"上传数据太大,超过限制!";
    }
    else{
        
        if ([JXPHTTPClient sharedInstance].currentErrorRespnse)
        {
            id  responseObject = [JXPHTTPClient sharedInstance].currentErrorRespnse;
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSArray *keyArray = ((NSDictionary *)responseObject).allKeys;
                
                for (NSString *key in keyArray) {
                    
                    if ([key isEqualToString:@"error"] && [[responseObject valueForKey:@"error"] isKindOfClass:[NSString class]]) {
                        
                        NSString *error = CHECK_STRING([responseObject valueForKey:@"error_description"]);
                        return error;
                    }
                }
            }
        }else{
            
            if ([[error localizedDescription] isEqualToString:@"Request failed: unauthorized (401)"]) {
                
                return @"该账号无访问权限";
            }else{
                
                return [error localizedDescription];
            }
        }
        return [error localizedDescription];
    }
}

#pragma mark - 错误 & 数据 解析

+ (void)checkResponseObject:(id)responseObject success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    id data = responseObject;
    if (data)
    {
        //判断Data是否字典类型
        if ([[data class] isSubclassOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = data;
            if ([dic.allKeys containsObject:@"code"]) {
                NSString *message = @"";
                if ([dic.allKeys containsObject:@"message"]) {
                    
                    message  = CHECK_STRING(dic[@"message"]);
                }
                switch ([CHECK_STRING(dic[@"code"]) integerValue]) {
                    case 0:
                        BLOCK(success)(data);//0:Success,成功
                        break;
                    case 10000:
                        BLOCK(success)(data);//10000:Error,一般错误
                        break;
                    case 10001:
                        BLOCK(success)(data);//10001:NotLogin,未登录
//                        [APPDELEGATE logOut];
//                        [APPDELEGATE.window.rootViewController showFailedWithMessage:isNil(message)?@"该账号未登录!":message];
                        break;
                    case 10002:
                        BLOCK(success)(data);//10002:NoRegist,未注册
                        //                        [APPDELEGATE logOut];
                        //                        [APPDELEGATE.window.rootViewController showFailedWithMessage:isNil(message)?@"该账号未注册!":message];
                        break;
                    case 10003:
                        BLOCK(success)(data);//10003:NoRegist,禁用
//                        [APPDELEGATE logOut];
//                        [APPDELEGATE.window.rootViewController showFailedWithMessage:isNil(message)?@"该账号被禁用!":message];
                        break;
                    case 10005:
                        BLOCK(success)(data);//10005:NotGod,不是大神
                        break;
                    default:
                        BLOCK(success)(data);
                        break;
                }
                
            }else{
                
                BLOCK(success)(data);
            }
        }
        else
        {
            BLOCK(success)(data);
        }
    }
    else
    {
        BLOCK(failure)(@"返回无相关信息!");
    }
}

- (UIProgressView *)progressView{
    
    if (_progressView == nil) {
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 20, kScreenWidth, 20)];
        //        _progressView
    }
    return _progressView;
}


@end
