//
//  TribleDes.h
//  DES算法
//
//  Created by My MacPro on 15/7/6.
//  Copyright (c) 2015年 My MacPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TribleDes : NSObject

- (NSString *)encData:(NSString *)data mainKey:(NSString *)key;
- (NSString *)decData:(NSString *)data mainKey:(NSString *)key;
- (NSString *)lisan:(NSString *)data mainKey:(NSString *)key;
@end
