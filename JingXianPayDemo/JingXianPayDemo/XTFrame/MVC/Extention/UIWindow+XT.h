//
//  UIWindow+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

//位置
typedef NS_ENUM(NSInteger, ViewLocation){
    kViewLocationTop,
    kViewLocationCenter,
    kViewLocationBottom,
};

//动画
typedef NS_ENUM(NSInteger, ViewAnimation){
    kViewAnimationTop,
    kViewAnimationBottom,
    kViewAnimationLeft,
    kViewAnimationRight,
};

@interface UIWindow (XT)

- (void)showBottomView:(UIView *)view;
- (void)showView:(UIView *)view location:(ViewLocation)location animation:(ViewAnimation)animation;

- (void)hideBottomView;
- (void)hideViewWithAnimation:(ViewAnimation)animation;

@end
