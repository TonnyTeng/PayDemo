//
//  JXPJSONModel.m
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPJSONModel.h"

@implementation JXPJSONModel

-(id)initWithDictionary:(NSDictionary*)d error:(NSError *__autoreleasing *)err
{
    NSMutableDictionary *dictionary = nil;
    NSDictionary *specialKeyDic = [self keyMapperSpecialKey];
    if (specialKeyDic)
    {
        dictionary = [[NSMutableDictionary alloc] initWithDictionary:d];
        for (NSString *key in [specialKeyDic allKeys])
        {
            if ([d objectForKey:key])
            {
                [dictionary setObject:[d objectForKey:key] forKey:[specialKeyDic objectForKey:key]];
                [dictionary removeObjectForKey:key];
            }
        }
    }
    
    self = [super initWithDictionary:dictionary ? dictionary : d error:err];
    
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[super toDictionary]];
    NSDictionary *specialKeyDic = [self keyMapperSpecialKey];
    if (specialKeyDic)
    {
        for (NSString *key in [specialKeyDic allKeys])
        {
            if ([dictionary objectForKey:specialKeyDic[key]])
            {
                [dictionary setObject:[dictionary objectForKey:specialKeyDic[key]] forKey:key];
                [dictionary removeObjectForKey:specialKeyDic[key]];
            }
        }
    }
    return dictionary;
}

-(NSDictionary *)keyMapperSpecialKey
{
    return nil;
}

#pragma mark - Other

+ (NSMutableArray *)initModelWithArray:(NSArray *)array model:(id)model
{
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array)
    {
        NSError *error = nil;
        id dataModel = [[model alloc] initWithDictionary:dic error:&error];
        if (!error)
        {
            [modelArray addObject:dataModel];
        }
        else
        {
            DDLogError(@"getBaseDataArrayWithType: Error%@",error);
        }
    }
    return modelArray;
}

@end
