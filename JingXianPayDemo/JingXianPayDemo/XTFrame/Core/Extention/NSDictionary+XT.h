//
//  NSDictionary+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XT)

- (BOOL)writeToPlistFilePath:(NSString *)filePath;
- (id)initWithPlistOfFilePath:(NSString *)filePath;

@end


@interface NSMutableDictionary (XT)

- (void)removeAllNilObjects;

@end
