//
//  XTSystemInfo.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IPHONE4_OR_BIGGER      (([[UIScreen mainScreen] bounds].size.height >= 480)?YES:NO)
#define IPHONE5_OR_BIGGER      (([[UIScreen mainScreen] bounds].size.height >= 568)?YES:NO)
#define IPHONE6_OR_BIGGER      (([[UIScreen mainScreen] bounds].size.height >= 667)?YES:NO)
#define IPHONE6_PLUS_OR_BIGGER (([[UIScreen mainScreen] bounds].size.height >= 736)?YES:NO)


#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

//#define IOS10_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"10.0"] != NSOrderedAscending )
#define IOS9_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )

#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER	(NO)
#define IOS6_OR_LATER	(NO)
#define IOS5_OR_LATER	(NO)
#define IOS4_OR_LATER	(NO)
#define IOS3_OR_LATER	(NO)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

@interface XTSystemInfo : NSObject


+ (NSString *)osVersion;

+ (NSString *)appVersion	NS_AVAILABLE_IOS(4_0);
+ (NSString *)appBuild      NS_AVAILABLE_IOS(4_0);
+ (NSString *)deviceModel	NS_AVAILABLE_IOS(4_0);
+ (NSString *)deviceUUID	NS_AVAILABLE_IOS(4_0);

+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory;
// 获取当前任务所占用的内存（单位：MB）
+ (double)usedMemory;
//获取当前设备剩余存储空间(单位：MB)
+ (NSString *)freeDiskSpaceInBytes;
+ (NSNumber *)freeDiskSpace;
//获取设备信息
+ (NSString*)deviceVersion;


@end
