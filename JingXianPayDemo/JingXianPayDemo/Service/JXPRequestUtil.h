//
//  JXPRequestUtil.h
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DataKey             @"data"
#define DataResposeKey      @"Respose"
#define DataCodeKey         @"code"


#define DataStateSuccessed  1
#define DataStateFailed     0

typedef void (^RequestSuccess)(NSDictionary *responseData);
typedef void (^RequestFailure)(NSString *errorInfo);
typedef void (^RequestProgress)(NSProgress *downloadProgress);

@interface JXPRequestUtil : NSObject

@property (nonatomic, copy) void(^progress)(id information);
@property (nonatomic, copy) void(^completion)(id information);
@property (nonatomic, copy) void(^failure)(id error);


#pragma mark - 加密解密

//+ (NSDictionary *)encryptParams:(id)params;
//+ (NSDictionary *)decryptParams:(NSDictionary *)params;

#pragma mark - 获取当前网络名称

+ (NSString *)getWifiName;
+ (NSString *)getWifiSSID;
+ (NSString *)checkWiFiMacAddressWithOldMac:(NSString *)oldMac;


#pragma mark - 取消请求
+ (void)cancelAllRequest;


#pragma mark - Account

/**
 *  注册
 *  @params action:userAction_register
 *  @params verifiType:token
 *  @params codeOrPswd:1
 *  @params activationCode:手机号
 *  @params mobile:locationBaidu
 *  @params password:手机号
 *  @params businessRangeId:经营范围
 *  @params businessAddress:经营地址
 

 */
+ (void)userActionRegisterWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 *  登录
 *  @params action:userAction_login
 *  @params uniqueId:token
 *  @params loginType:1
 *  @params mobile:手机号
 *  @params locationBaidu:locationBaidu
 *  @params password:手机号
 *  @params bankCard:银行卡号
 *  @params registration_id:
 *  @params cityName:
 *  @params cityCode:
 */
+ (void)userActionLoginWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;


#pragma mark - Business
/**
 *  经营范围
 *  @params action:userAction_getBusinessRangeList
 */
+ (void)userActionGetBusinessRangeListWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;



#pragma mark - 修改提现类型
/**
 *  经营范围
 *  @params action:userAction_getBusinessRangeList
 */
+ (void)userActionUpdateCashWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;



@end
