//
//  JXPJSONModel.h
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JXPJSONModel : JSONModel

/**
 *  特殊处理字段
 *
 *  @return 如服务器字段命名不规范，只需继承此方法提供服务器字段KEY和正确字段KEY；
 *  例子：@[@"isOpen"（错误命名，JSONModel不能进行处理）:@"is_Open"(正确命名，可以进行处理)]
 */

-(NSDictionary *)keyMapperSpecialKey;

#pragma mark - Other

+ (NSMutableArray *)initModelWithArray:(NSArray *)array model:(id)model;

@end
