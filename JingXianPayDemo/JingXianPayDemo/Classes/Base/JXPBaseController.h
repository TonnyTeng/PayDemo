//
//  JXPBaseController.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTViewController.h"

@interface JXPBaseController : XTViewController
{
    
    UIView *navTitleItemView;
    UIImageView *arrowImageView;
    UIButton *navTitleItemButton;
    UIWebView *callWebview;
    NSString *callServiceNumber;
    NSInteger callServiceLine;
}

@property (nonatomic, strong) XTTabBarController *rootTabBarVC;
- (UIViewController *)topViewController;
- (void)showLoading;
- (void)setNavigationTitle:(NSString *)title;
- (void)showBackButtonItem;
- (void)showDismissButtonItem;

- (void)showLeftButtonItemWithTitle:(NSString *)title Sel:(SEL)sel;
- (void)showLeftButtonItemWithImage:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName Sel:(SEL)sel;

- (void)showRightButtonItemWithTitle:(NSString *)title Sel:(SEL)sel;
- (void)showRightButtonItemWithImage:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName Sel:(SEL)sel;
- (void)dismissAction;

- (void)popupViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;

- (BOOL)gestureRecognizerShouldBegin;
//检测版本信息
- (void)checkVersionInfo;

- (void)showLoginVC;

- (void)showHomeVC;

@end
