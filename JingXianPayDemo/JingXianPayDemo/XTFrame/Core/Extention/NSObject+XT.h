//
//  NSObject+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef	SAFE_RELEASE
#define SAFE_RELEASE(object)            [object release];object=nil


extern BOOL isNil(id value);


@protocol KeyboardNotificationProtocol <NSObject>
@optional

//- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration;
//- (void)keyboardDidShow:(CGRect)frame duration:(NSTimeInterval)duration;
//- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration;
//- (void)keyboardDidHide:(CGRect)frame duration:(NSTimeInterval)duration;
//- (void)keyboardWillChangeFrame:(CGRect)frame duration:(NSTimeInterval)duration;
//- (void)keyboardDidChangeFrame:(CGRect)frame duration:(NSTimeInterval)duration;

@end


@interface NSObject (XT)

- (NSData *)toData;
- (NSDate *)toDate;
- (NSNumber *)toNumber;
- (NSString *)toString;

@end


@interface NSObject (Notification)<KeyboardNotificationProtocol>

- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;

- (void)registerNotification:(NSString *)name object:(id)object selector:(SEL)selector;
- (void)removeNotification:(NSString *)name;
- (void)removeAllNotifications;

- (void)postNotification:(NSString *)name;
- (void)postNotification:(NSString *)name object:(NSObject *)object;

@end
