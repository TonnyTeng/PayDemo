//
//  NSObject+XT.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "NSObject+XT.h"

@implementation NSObject (XT)

extern BOOL isNil(id value)
{
    if (value == nil || value == NULL)
    {
        return YES;
    }
    if ([value isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([value isKindOfClass:[NSString class]])
    {
        if (((NSString*)value).length > 0)
        {
            if ([value isEqualToString:@"(null)"]||[value isEqualToString:@"null"]||[value isEqualToString:@"<null>"])
            {
                return YES;
            }
        }
        else
        {
            return YES;
        }
    }
    return NO;
}

- (NSData *)toData{
    if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSAssert(NO, @"该类型（%@）不能转换为NSData类型",[self class]);
    return nil;
}

- (NSDate *)toDate{
    if ( [self isKindOfClass:[NSDate class]] ){
        return (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]){
        return [(NSString *)self dateWithFormate:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    if ([self isKindOfClass:[NSNumber class]]){
        return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)self doubleValue]];
    }
    
    NSAssert(NO, @"该类型（%@）不能转换为NSDate类型",[self class]);
    return nil;
}

- (NSNumber *)toNumber{
    if ([self isKindOfClass:[NSNumber class]]){
        return (NSNumber *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]){
        return [NSNumber numberWithDouble:[(NSString *)self doubleValue]];
    }
    
    if ([self isKindOfClass:[NSDate class]]){
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    }
    
    if ([self isKindOfClass:[NSNull class]]){
        return [NSNumber numberWithInteger:0];
    }
    
    NSAssert(NO, @"该类型（%@）不能转换为NSNumber类型",[self class]);
    return nil;
}

- (NSString *)toString{
    if ([self isKindOfClass:[NSString class]]){
        return (NSString *)self;
    }
    
    if ([self isKindOfClass:[NSData class]]){
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding] ;
    }
    
    if ([self isKindOfClass:[NSDate class]]){
        return [(NSDate *)self stringWithFormate:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    if ([self isKindOfClass:[NSNumber class]]){
        return [(NSNumber *)self stringValue];
    }
    
    return self.description;
}

@end

@implementation NSObject (Notification)

- (void)registerKeyboardNotification{
    NSNotificationCenter *keyboardNoti = [NSNotificationCenter defaultCenter];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidShowNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidHideNotification object:nil];
    if (IOS5_OR_LATER) {
        [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}
- (void)removeKeyboardNotification{
    NSNotificationCenter *keyboardNoti = [NSNotificationCenter defaultCenter];
    [keyboardNoti removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    if (IOS5_OR_LATER) {
        [keyboardNoti removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [keyboardNoti removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

- (void)registerNotification:(NSString *)name object:(id)object selector:(SEL)selector{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:object];
}
- (void)removeNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}
- (void)removeAllNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
- (void)postNotification:(NSString *)name object:(NSObject *)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

//处理键盘通知
- (void)handleKeyboardNotification:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect beginFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
//    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
//        if ([self respondsToSelector:@selector(keyboardWillShow:duration:)]) {
//            [self keyboardWillShow:beginFrame duration:duration];
//        }
//    }else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
//        if ([self respondsToSelector:@selector(keyboardDidShow:duration:)]) {
//            [self keyboardDidShow:endFrame duration:duration];
//        }
//    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
//        if ([self respondsToSelector:@selector(keyboardWillHide:duration:)]) {
//            [self keyboardWillHide:beginFrame duration:duration];
//        }
//    }else if ([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
//        if ([self respondsToSelector:@selector(keyboardDidHide:duration:)]) {
//            [self keyboardDidHide:endFrame duration:duration];
//        }
//    }else if ([notification.name isEqualToString:UIKeyboardWillChangeFrameNotification]) {
//        if ([self respondsToSelector:@selector(keyboardWillChangeFrame:duration:)]) {
//            [self keyboardWillChangeFrame:beginFrame duration:duration];
//        }
//    }else if ([notification.name isEqualToString:UIKeyboardDidChangeFrameNotification]) {
//        if ([self respondsToSelector:@selector(keyboardDidChangeFrame:duration:)]) {
//            [self keyboardDidChangeFrame:endFrame duration:duration];
//        }
//    }
}

@end
