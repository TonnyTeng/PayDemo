//
//  XTLoadingView.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTLoadingView.h"

#define TAG_LOADINGVIEW     191919
#define FONG_MESSAGE        [UIFont systemFontOfSize:16]
#define SIZE_ICON           40
#define SIZE_HEIGHT         60
#define SIZE_WIDTH          250


@interface XTLoadingView ()
@property (nonatomic, strong) XTView *contentView;
@property (nonatomic, strong) XTImageView *bgImageView;
@property (nonatomic, strong) XTImageView *statusImageView;
@property (nonatomic, strong) XTLabel *messageLabel;
@end

@implementation XTLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //容器
        CGRect contentFrame = CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT);
        _contentView = [[XTView alloc] initWithFrame:contentFrame];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentView];
        
        //背景图片
        CGRect bgFrame = _contentView.bounds;
        _bgImageView = [[XTImageView alloc] initWithFrame:bgFrame];
        [_bgImageView setImage:[UIImage stretchableImageNamed:@"loading_bg"]];
        [_contentView addSubview:_bgImageView];
        
        //状态图片
        CGRect statusFrame = CGRectMake(10,10, SIZE_ICON, contentFrame.size.height-20);
        _statusImageView = [[XTImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeCenter];
        [_contentView addSubview:_statusImageView];
        
        //提示信息
        CGRect messageFrame = CGRectMake(SIZE_ICON+20,10,contentFrame.size.width-(SIZE_ICON+30),contentFrame.size.height-20);
        _messageLabel = [[XTLabel alloc] initWithFrame:messageFrame];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setTextColor:[UIColor whiteColor]];
        [_messageLabel setNumberOfLines:999999];
        [_messageLabel setFont:FONG_MESSAGE];
        [_contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect bgFrame = _contentView.bounds;
    [_bgImageView setFrame:bgFrame];
    
    CGRect statusFrame = CGRectMake(10,10, SIZE_ICON, _contentView.bounds.size.height-20);
    [_statusImageView setFrame:statusFrame];
    
    CGRect messageFrame = CGRectMake(SIZE_ICON+20,10,_contentView.bounds.size.width-(SIZE_ICON+30),_contentView.bounds.size.height-20);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (XTLoadingView *)loadingViewInView:(UIView *)view{
    XTLoadingView *loadingView = (XTLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XTLoadingView alloc] init];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setFrame:view.bounds];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message{
    CGSize contentSize = [message sizeWithFont:FONG_MESSAGE byWidth:SIZE_WIDTH-SIZE_ICON-30];
    contentSize.width = contentSize.width+SIZE_ICON+30;
    contentSize.height = (contentSize.height<(SIZE_HEIGHT-20)?(SIZE_HEIGHT-20):contentSize.height)+20;
    return contentSize;
}

/**********************************************************************/
#pragma mark - Puboic Methods
/**********************************************************************/

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    loadingView.backgroundColor  = [UIColor redColor];
    [loadingView.statusImageView setImage:[UIImage animatedImageNamed:@"loading" duration:1.5f]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"img_icon_card_tag"]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    
    //延迟隐藏
    [UIView animateWithDuration:0.2f delay:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [loadingView setAlpha:0];
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"img_icon_cry_white"]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
    
    //延迟隐藏
    [UIView animateWithDuration:0.2f delay:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [loadingView setAlpha:0];
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XTLoadingView *loadingView = (XTLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        return;
    }
    
    //隐藏动画
    if (animated) {
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [loadingView setAlpha:0];
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
    } else {
        [loadingView removeFromSuperview];
    }
}


@end
