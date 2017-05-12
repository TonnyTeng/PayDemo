//
//  UIWindow+XT.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "UIWindow+XT.h"

#define VIEWTAG_COVERVIEW           10000
#define VIEWTAG_CONTENTVIEW         10001

@implementation UIWindow (XT)

- (CGPoint)getCenter:(UIView *)view location:(ViewLocation)location{
    CGSize windowSize = self.bounds.size;
    CGSize viewSize = view.bounds.size;
    CGPoint center = view.center;
    
    switch (location) {
        case kViewLocationTop:{
            center.x = windowSize.width/2;
            center.y = viewSize.height/2;
        }break;
        case kViewLocationCenter:{
            center.x = windowSize.width/2;
            center.y = windowSize.height/2;
        }break;
        case kViewLocationBottom:{
            center.x = windowSize.width/2;
            center.y = windowSize.height - viewSize.height/2;
        }break;
    }
    return center;
}

- (CGPoint)offsetCenter:(UIView *)view animation:(ViewAnimation)animation{
    CGSize windowSize = self.bounds.size;
    CGSize viewSize = view.bounds.size;
    CGPoint center = view.center;
    
    switch (animation) {
        case kViewAnimationTop:{
            center.y = 0 - viewSize.height/2;
        }break;
        case kViewAnimationBottom:{
            center.y = windowSize.height + viewSize.height/2;
        }break;
        case kViewAnimationLeft:{
            center.x = 0 - viewSize.width/2;
        }break;
        case kViewAnimationRight:{
            center.x = windowSize.width + viewSize.width/2;
        }break;
    }
    return center;
}


- (void)showBottomView:(UIView *)view{
    [self showView:view location:kViewLocationBottom animation:kViewAnimationBottom];
}
- (void)showView:(UIView *)view location:(ViewLocation)location animation:(ViewAnimation)animation{
    __block UIView *coverView = [self viewWithTag:VIEWTAG_COVERVIEW];
    __block UIView *contentView = [self viewWithTag:VIEWTAG_CONTENTVIEW];
    if (!coverView && !contentView) {
        
        //添加遮罩层
        coverView = [[UIView alloc] initWithFrame:self.bounds];
        [coverView setTag:VIEWTAG_COVERVIEW];
        [self addSubview:coverView];
        
        //添加视图层
        contentView = view;
        [contentView setTag:VIEWTAG_CONTENTVIEW];
        [self addSubview:contentView];
        
        //入场动画
        [coverView setBackgroundColor:[UIColor blackColor]];
        [coverView setAlpha:0.0f];
        CGPoint endCenter = [self getCenter:contentView location:location];
        [contentView setCenter:endCenter];
        [contentView setCenter:[self offsetCenter:contentView animation:animation]];
        [UIView animateWithDuration:0.26f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [coverView setAlpha:0.4f];
            [contentView setCenter:endCenter];
        } completion:nil];
    }
}

- (void)hideBottomView{
    [self hideViewWithAnimation:kViewAnimationBottom];
}
- (void)hideViewWithAnimation:(ViewAnimation)animation{
    __block UIView *coverView = [self viewWithTag:VIEWTAG_COVERVIEW];
    __block UIView *contentView = [self viewWithTag:VIEWTAG_CONTENTVIEW];
    if (coverView || contentView) {
        CGPoint endCenter = [self offsetCenter:contentView animation:animation];
        
        //出场动画
        [UIView animateWithDuration:0.26f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [coverView setAlpha:0.0f];
            [contentView setCenter:endCenter];
        } completion:^(BOOL finished) {
            [coverView removeFromSuperview];coverView = nil;
            [contentView removeFromSuperview];contentView = nil;
        }];
    }
}


@end
