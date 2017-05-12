//
//  NSDictionary+XT.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "NSDictionary+XT.h"

@implementation NSDictionary (XT)

- (BOOL)writeToPlistFilePath:(NSString *)filePath
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    BOOL didWriteSuccessfull = [data writeToFile:filePath atomically:YES];
    return didWriteSuccessfull;
}

- (id)initWithPlistOfFilePath:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end


@implementation NSMutableDictionary (XT)


- (void)removeAllNilObjects
{
    NSArray *allKeys = [self allKeys];
    for (NSString *key in allKeys)
    {
        id object = [self objectForKey:key];
        if (!object || [object isKindOfClass:[NSNull class]])
        {
            [self removeObjectForKey:key];
        }
        else if([[object class] isSubclassOfClass:[NSString class]])
        {
            if ([object isEqualToString:@" "] || [object isEqualToString:@"null"])
            {
                [self removeObjectForKey:key];
            }
        }
    }
}

@end
