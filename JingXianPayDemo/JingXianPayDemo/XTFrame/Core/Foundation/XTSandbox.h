//
//  XTSandbox.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTSandbox : NSObject

+ (NSString *)appPath;          // 程序目录，不能存任何东西
+ (NSString *)docPath;          // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;      // 配置目录，配置文件存这里
+ (NSString *)libCachePath;     // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;          // 缓存目录，APP退出后，系统可能会删除这里的内容

@end
