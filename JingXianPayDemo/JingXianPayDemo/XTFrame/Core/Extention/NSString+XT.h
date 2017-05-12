//
//  NSString+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 非空字符
#define Regex_NotNull       @"/S"
// 电子邮件
#define Regex_Email         @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
// 用户密码
#define Regex_Password      @"^[A-Za-z0-9]{6,32}$"
// 中文字符
#define Regex_China          @"^[\\u4E00-\\u9FA5]+$"


#define CHECK_STRING(NSSTRING) (!isNil(NSSTRING) ? [NSString stringWithFormat:@"%@",NSSTRING] : @"")
#define degreesToRadians(x) (M_PI*(x)/180.0)  // 角度


@interface NSString (XT)


+ (NSString *)newUUID;
+ (NSString *)mechineID;

- (NSString *)md5Digest;
- (NSString *)sha1Digest;
- (NSString *)encryUsePassWordDESKey:(NSString *)key andIv:(NSString *)authIv;
- (NSString *)base64Decoded;
- (NSString *)base64Encoded;
- (NSString *)decryptUseDESKey:(NSString*)key;
- (NSString *)encryptUseDESKey:(NSString *)key;


- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;
- (CGSize)getSpaceLabelHeightWithFont:(UIFont *)font withWidth:(CGFloat)width;

- (BOOL)isHaveString:(NSString *)string;
- (BOOL)isMatch:(NSString *)regex;
- (NSDate *)dateWithFormate:(NSString *)formate;

//判断是否有效的身份证
- (BOOL)isIDCard;
//校验密码，字母或数字
+ (BOOL)isPassword:(NSString *)password;
//校验手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

- (BOOL)checkBankCardNo;//判断银行卡号
/**
 *  查询是哪个银行
 *
 *  @param numbers 获取的numbers
 *  @param nCount  数组个数
 *
 *  @return 所属银行
 */
+ (NSString *)getBankNameByBin:(char *)numbers count:(int)nCount;
- (NSString *)getBankName;//根据卡号 获取银行名称
+ (NSString *)getBankName:(NSString*) idCard;//根据卡号 获取银行名称
//根据身份证号获取出生日期
- (NSString *)getBrithdayFromIdCard;
- (NSInteger)getAgeWithFromIdCard;

+ (NSString *)hmacSha1:(NSString*)key text:(NSString*)text;

// url的参数字符串转字典
- (NSDictionary *)urlQueryStringToDictionary;
//字典转URL格式
- (NSString *)toUrlQueryStringWithDictionary:(NSDictionary *)dic;

//不完全显示银行卡号
+ (NSMutableString *)notFullyDisplayBankNumberStringWith:(NSString *)str;


//多色Label
- (NSMutableAttributedString *)multipleColorWithLabel:(NSString *)string color:(UIColor *)color length:(NSInteger)length;


@end
