//
//  UINavigationController+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (XT)


- (void)pushViewController:(UIViewController*)controller animatedWithTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;


@end
