//
//  XTLoadingView.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTView.h"

@interface XTLoadingView : XTView

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideInView:(UIView *)view animated:(BOOL)animated;

@end
