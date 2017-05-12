//
//  XTDTLoadingView.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTDTLoadingView.h"

#define TAG_LOADINGVIEW     181818
#define FONG_MESSAGE        [UIFont systemFontOfSize:14]
#define SIZE_ICON           40
#define SIZE_HEIGHT         40
#define SIZE_WIDTH          200

@interface XTDTLoadingView ()

@property (nonatomic, strong) XTView *contentView;
@property (nonatomic, strong) XTImageView *statusImageView;
@property (nonatomic, strong) XTLabel *messageLabel;
@end

@implementation XTDTLoadingView

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
        
        //状态图片
        CGRect statusFrame = CGRectMake(0,0, SIZE_WIDTH, SIZE_ICON);
        _statusImageView = [[XTImageView alloc] initWithFrame:statusFrame];
        [_statusImageView setContentMode:UIViewContentModeCenter];
        [_contentView addSubview:_statusImageView];
        
        //提示信息
        CGRect messageFrame = CGRectMake(0,SIZE_ICON,SIZE_WIDTH,SIZE_HEIGHT-SIZE_ICON);
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
    
    CGRect statusFrame = CGRectMake(0,0, _contentView.bounds.size.width, SIZE_ICON);
    [_statusImageView setFrame:statusFrame];
    
    CGRect messageFrame = CGRectMake(0,SIZE_ICON+10,_contentView.bounds.size.width,_contentView.bounds.size.height-SIZE_ICON);
    [_messageLabel setFrame:messageFrame];
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

+ (XTDTLoadingView *)loadingViewInView:(UIView *)view{
    XTDTLoadingView *loadingView = (XTDTLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[XTDTLoadingView alloc] init];
        [loadingView setTag:TAG_LOADINGVIEW];
        [loadingView setCenter:view.center];
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGSize)contentSizeOfMessage:(NSString *)message{
    CGSize contentSize = [message sizeWithFont:FONG_MESSAGE byWidth:SIZE_WIDTH];
    contentSize.width = contentSize.width<SIZE_ICON?SIZE_ICON:contentSize.width;
    contentSize.height = contentSize.height+SIZE_ICON+10;
    return contentSize;
}

/**********************************************************************/
#pragma mark - Puboic Methods
/**********************************************************************/

+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTDTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage animatedImageNamed:@"loading" duration:1.5f]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTDTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    [loadingView.statusImageView setImage:[UIImage imageNamed:@"comm_bg_no_network"]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}

+ (void)showNotDataMessage:(NSString *)message inView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:message];
    
    //设置内容
    XTDTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:message];
    //    [loadingView.statusImageView setImage:[UIImage imageNamed:@"comm_bg_no_network"]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}

+ (void)showNoInfoInView:(UIView *)view{
    CGSize contentSize = [self contentSizeOfMessage:nil];
    
    //设置内容
    XTDTLoadingView *loadingView = [self loadingViewInView:view];
    [loadingView.messageLabel setText:nil];
    //    [loadingView.statusImageView setImage:[UIImage imageNamed:@"common_img_noinfo"]];
    [loadingView.contentView setFrame:CGRectMake((loadingView.bounds.size.width-contentSize.width)/2,
                                                 (loadingView.bounds.size.height-contentSize.height)/2,
                                                 contentSize.width,
                                                 contentSize.height)];
}


+ (void)hideInView:(UIView *)view animated:(BOOL)animated{
    XTDTLoadingView *loadingView = (XTDTLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
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
