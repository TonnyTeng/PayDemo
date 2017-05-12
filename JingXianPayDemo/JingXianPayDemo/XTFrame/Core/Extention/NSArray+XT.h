//
//  NSArray+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XT)

- (NSArray *)head:(NSUInteger)count;
- (NSArray *)tail:(NSUInteger)count;

@end


@interface NSMutableArray (XT)

- (NSMutableArray *)pushHead:(NSObject *)obj;
- (NSMutableArray *)popHead;

- (NSMutableArray *)pushHeads:(NSArray *)all;
- (NSMutableArray *)popHeads:(NSUInteger)n;

- (NSMutableArray *)pushTail:(NSObject *)obj;
- (NSMutableArray *)popTail;

- (NSMutableArray *)pushTails:(NSArray *)all;
- (NSMutableArray *)popTails:(NSUInteger)n;

- (NSMutableArray *)keepHead:(NSUInteger)n;
- (NSMutableArray *)keepTail:(NSUInteger)n;

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;

@end
