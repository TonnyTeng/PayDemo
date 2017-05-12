//
//  NSArray+XT.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "NSArray+XT.h"

@implementation NSArray (XT)

- (NSArray *)head:(NSUInteger)count{
    if ([self count]<count){
        return [NSArray arrayWithArray:self];
    }
    return [self subarrayWithRange:NSMakeRange(0, count)];
}

- (NSArray *)tail:(NSUInteger)count{
    if ([self count]<count) {
        return [NSArray arrayWithArray:self];
    }
    return [self subarrayWithRange:NSMakeRange([self count]-count, count)];
}

@end


@implementation NSMutableArray (XT)

- (NSMutableArray *)pushHead:(NSObject *)obj{
    if (obj) {
        [self insertObject:obj atIndex:0];
    }
    return self;
}
- (NSMutableArray *)popHead{
    if ([self count]>0) {
        [self removeObjectAtIndex:0];
    }
    return self;
}

- (NSMutableArray *)pushHeads:(NSArray *)all{
    if ([all count]>0){
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self insertObjects:all atIndexes:indexSet];
    }
    return self;
}
- (NSMutableArray *)popHeads:(NSUInteger)n{
    if ([self count]>n) {
        NSRange range = NSMakeRange(0, n);
        [self removeObjectsInRange:range];
    } else {
        [self removeAllObjects];
    }
    return self;
}

- (NSMutableArray *)pushTail:(NSObject *)obj{
    if (obj) {
        [self addObject:obj];
    }
    return self;
}
- (NSMutableArray *)popTail{
    if ([self count]>0){
        [self removeObjectAtIndex:[self count]-1];
    }
    return self;
}

- (NSMutableArray *)pushTails:(NSArray *)all{
    if ([all count]) {
        [self addObjectsFromArray:all];
    }
    return self;
}
- (NSMutableArray *)popTails:(NSUInteger)n{
    if ([self count]>n) {
        NSRange range = NSMakeRange(n, [self count]-n);
        [self removeObjectsInRange:range];
    } else {
        [self removeAllObjects];
    }
    return self;
}

- (NSMutableArray *)keepHead:(NSUInteger)n{
    if ([self count]>n) {
        NSRange range = NSMakeRange(n, [self count]-n);
        [self removeObjectsInRange:range];
    }
    return self;
}

- (NSMutableArray *)keepTail:(NSUInteger)n{
    if ([self count]>n){
        NSRange range = NSMakeRange(0, [self count]-n);
        [self removeObjectsInRange:range];
    }
    return self;
}

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2{
    id object = [self objectAtIndex:index1];
    if (object) {
        [self removeObjectAtIndex:index1];
        [self insertObject:object atIndex:index2];
    }
}

@end
