//
//  JXPClient.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class JXPUserModel;

@interface JXPClient : NSObject

@property (nonatomic, strong) NSString               *currentLocationCity;      //当前定位城市
@property (nonatomic, strong) NSString               *currentLocationDistrict;  //当前定位区
@property (nonatomic, strong) NSString               *currentLocationDesc;      //当前定位地址
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;           //当前定位位置

@property (nonatomic, assign) BOOL                   isNetwork;                 //是否有网络
@property (nonatomic, assign) BOOL                   isWifi;                    //是否是wifi
@property (nonatomic, assign) BOOL                   isEncrypt;                 //是否加密

@property (nonatomic, strong) NSArray                *blueToothDeviceUUIDArray; //保存在手机里的蓝牙UUID
@property (nonatomic, strong) NSString               *mobilePhoneUDID;          //获取唯一标示
@property (nonatomic, strong) NSString               *typeId;//21

@property (nonatomic, strong) JXPUserModel           *user;

AS_SINGLETON(JXPClient)

- (void)signOutUser;
- (void)startLocation;
- (void)stopLocation;

@end
