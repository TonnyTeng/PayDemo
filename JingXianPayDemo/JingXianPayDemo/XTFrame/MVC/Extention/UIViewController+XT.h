//
//  UIViewController+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef	SAFE_RELEASE_CONTROLLER
#define SAFE_RELEASE_CONTROLLER(controller)    [controller removeFromParentViewController];controller=nil;

@interface UIViewController (XT)

#pragma mark - HUD And Loading Methods

//Hud Methods
- (void)showLoadingWithMessage:(NSString *)message progress:(CGFloat)progress;
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message;
- (void)showFailedWithMessage:(NSString *)message;
- (void)hideLoading;

- (void)showBGLoadingWithMessage:(NSString *)message;
- (void)showBGFailedWithMessage:(NSString *)message;
- (void)showBGNotDataWithMessage:(NSString *)message;
- (void)showBGNoInfo;
- (void)hideBGLoading;

//Toast Methods
- (void)showAlertView:(NSString *)message;
- (void)showAlertView:(NSString *)message block:(void (^)(NSInteger buttonIndex))block;
- (void)showAlertView:(NSString *)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle block:(void (^)(NSInteger buttonIndex))block;


@end
