//
//  UIView+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef	SAFE_RELEASE_SUBVIEW
#define SAFE_RELEASE_SUBVIEW(view)      [view removeFromSuperview];view=nil;

#undef	SAFE_RELEASE_SUBLAYER
#define SAFE_RELEASE_SUBLAYER(layer)    [layer removeFromSuperlayer];layer=nil;

@interface UIView (XT)<UIAlertViewDelegate,UIActionSheetDelegate>

- (void)setCorner:(CGFloat)corner;

- (void)setBorder:(CGFloat)border color:(UIColor *)color;

- (void)setShadow:(CGSize)offset corner:(CGFloat)corner opacity:(CGFloat)opacity color:(UIColor *)color;

#pragma mark - BlockUI
//UIAlertView
-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

//UIActionSheet
-(void)showInView:(UIView *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromToolbar:(UIToolbar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromTabBar:(UITabBar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

#pragma mark - FrameAdjust

- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)tail;
- (void)setTail:(CGFloat)tail;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

@end
