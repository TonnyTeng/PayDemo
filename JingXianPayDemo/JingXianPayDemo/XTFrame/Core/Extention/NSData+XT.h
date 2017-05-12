//
//  NSData+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XT)

- (NSData*) md5Digest;
- (NSData*) sha1Digest;

- (NSData *)base64Decoded;
- (NSString *)base64Encoded;

@end
