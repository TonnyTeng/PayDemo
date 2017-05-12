//
//  DesUtil.h
//  DESUtil
//
//  Created by su on 14/7/8.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class
 @abstract 3DES解密工具
 @discussion
 */
@interface DesUtil : NSObject
/*!
 @method
 @abstract 3DES解密
 @discussion 以下参数均为十六进制字符串
 @param data 待解密数据
 @param key des 密钥
 @param random 随机数
 @return
 */
+ (NSString*)tripleDesDecrypt:(NSString*)data key:(NSString*)key random:(NSString*)random;
/*!
 @method
 @abstract 3DES解密
 @discussion 以下参数均为十六进制字符串
 @param data 待解密数据
 @param key des 密钥
 @return
 */
+ (NSString*)tripleDesDecrypt:(NSString*)data key:(NSString*)key;
@end
