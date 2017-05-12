//
//  UIViewController+XT.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "UIViewController+XT.h"

#import "XTLoadingView.h"
#import "XTDTLoadingView.h"
#import "MBProgressHUD.h"

@implementation UIViewController (XT)

#pragma mark - HUD And Loading Methods

- (void)showLoadingWithMessage:(NSString *)message progress:(CGFloat)progress{
    
    [self hideLoading];
    MBProgressHUD *hud = nil;
    for (UIView *view in self.view.subviews) {
        
        if (view.tag == 20171022 &&
            [view isKindOfClass:[MBProgressHUD class]]) {
            
            hud = (MBProgressHUD *)view;
            break;
        }
    }
    if (!hud) {
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.tag = 20170122;
        //    hud.labelText = message;
        hud.detailsLabelText= message;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:17];
    }
    hud.progress = progress;
}

//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message
{
    [self hideLoading];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.labelText = message;
    hud.detailsLabelText= message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:17];
}

- (void)showSuccessWithMessage:(NSString *)message
{
    [self hideLoading];
    if (!isNil(message)) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//APPDELEGATE.window
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText= message;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:17];
        [hud hide:YES afterDelay:1.5];
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
        //        hud.mode = MBProgressHUDModeText;
        //        hud.labelText = message;
        //        [hud hide:YES afterDelay:1.0];
    }
}

- (void)showFailedWithMessage:(NSString *)message
{
    [self hideLoading];
    if (!isNil(message)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//APPDELEGATE.window
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText= message;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:17];
        [hud hide:YES afterDelay:1.5];
        
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
        //        hud.mode = MBProgressHUDModeText;
        //        hud.labelText = message;
        //        [hud hide:YES afterDelay:1.0];
    }
}

- (void)hideLoading
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[MBProgressHUD class]])
        {
            [view removeFromSuperview];
            break;
        }
    }
}

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message{
    [self hideLoading];
    [XTDTLoadingView showLoadingMessage:message inView:self.view];
}
- (void)showBGFailedWithMessage:(NSString *)message{
    [self hideLoading];
    [XTDTLoadingView showFailedMessage:message inView:self.view];
}
- (void)showBGNotDataWithMessage:(NSString *)message{
    [self hideLoading];
    [XTDTLoadingView showNotDataMessage:message inView:self.view];
}
- (void)showBGNoInfo{
    [self hideLoading];
    [XTDTLoadingView showNoInfoInView:self.view];
}
- (void)hideBGLoading{
    [self hideLoading];
    [XTDTLoadingView hideInView:self.view animated:NO];
}

//Toast Methods
- (void)showAlertView:(NSString *)message
{
    [self hideLoading];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alerView show];
}


- (void)showAlertView:(NSString *)message block:(void (^)(NSInteger buttonIndex))block
{
    [self hideLoading];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    
    [alerView showWithCompletionHandler:^(NSInteger buttonIndex)
     {
         BLOCK(block)(buttonIndex);
     }];
}

- (void)showAlertView:(NSString *)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle block:(void (^)(NSInteger buttonIndex))block
{
    [self hideLoading];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:cancelButtonTitle
                                             otherButtonTitles:otherButtonTitle,nil];
    [alerView showWithCompletionHandler:^(NSInteger buttonIndex)
     {
         BLOCK(block)(buttonIndex);
     }];
}

@end
