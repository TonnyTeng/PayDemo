//
//  JXPBaseController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPBaseController.h"

@interface JXPBaseController ()<UIGestureRecognizerDelegate>

@end

@implementation JXPBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:5]} forState:UIControlStateNormal];
    [self showBackButtonItem];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenLoadingMessage) name:@"enterBackground" object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hiddenLoadingMessage{
    
    [self hideLoading];
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden//for iOS7.0
{
    return NO;
}

- (void)setNavigationTitle:(NSString *)title
{
    self.title = title;
}

- (void)setLeftButtonItemWithTitleName:(NSString *)titleName
                   backgroundImageName:(NSString *)backgroundImageName
                  highlightedImageName:(NSString *)highlightedImageName
                                action:(SEL)action{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleName style:UIBarButtonItemStyleDone target:self action:action];
    
    
    UIImage *backgroundImage = [[UIImage imageNamed:backgroundImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationItem.leftBarButtonItem setImage:backgroundImage];
    
    //    UIImage *highlightedImage = [[UIImage imageNamed:highlightedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    [self.navigationItem.leftBarButtonItem setBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [self.navigationItem.leftBarButtonItem setBackgroundImage:highlightedImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)setRightButtonItemWithTitleName:(NSString *)titleName
                    backgroundImageName:(NSString *)backgroundImageName
                   highlightedImageName:(NSString *)highlightedImageName
                                 action:(SEL)action{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleName style:UIBarButtonItemStyleDone target:self action:action];
    //    self.navigationItem.rightBarButtonItem.tintColor = kGCColorButtonTitle;
    
    UIImage *backgroundImage = [[UIImage imageNamed:backgroundImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationItem.rightBarButtonItem setImage:backgroundImage];
    
    //    UIImage *highlightedImage = [[UIImage imageNamed:highlightedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    [self.navigationItem.rightBarButtonItem setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [self.navigationItem.rightBarButtonItem setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)showBackButtonItem
{
    if (!self.previousViewController)
    {
        [self showDismissButtonItem];
        return;
    }
    UIImage *selectedImage=[UIImage imageNamed:@"gc_back"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //开启iOS7及以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)showDismissButtonItem
{
    UIImage *selectedImage=[UIImage imageNamed: @"gc_back"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(dismissAction)];
}

- (void)showLeftButtonItemWithTitle:(NSString *)title Sel:(SEL)sel
{
    [self setLeftButtonItemWithTitleName:title backgroundImageName:nil highlightedImageName:nil action:sel];
}

- (void)showLeftButtonItemWithImage:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName Sel:(SEL)sel
{
    [self setLeftButtonItemWithTitleName:@" " backgroundImageName:imageName highlightedImageName:highlightedImageName action:sel];
}

- (void)showRightButtonItemWithTitle:(NSString *)title Sel:(SEL)sel
{
    [self setRightButtonItemWithTitleName:title backgroundImageName:nil highlightedImageName:nil action:sel];
}

- (void)showRightButtonItemWithImage:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName Sel:(SEL)sel
{
    [self setRightButtonItemWithTitleName:@" " backgroundImageName:imageName highlightedImageName:highlightedImageName action:sel];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)rightButtonAction:(id)sender
{
    
}

- (void)popupViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion {
    
    UIViewController *top = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [top addChildViewController:controller];
    [top.view addSubview:controller.view];
}

- (UIViewController *)topViewController {
    UIViewController *topController = self.parentViewController;
    while (topController.parentViewController) {
        topController = topController.parentViewController;
    }
    return topController;
}

//MARK:UIGestureRecognizerDelegate 侧滑重写协议
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return [self gestureRecognizerShouldBegin];;
}

- (BOOL)gestureRecognizerShouldBegin {
    
    DDLogInfo(@"~~~~~~~~~~~%@控制器 滑动返回~~~~~~~~~~~~~~~~~~~",[self class]);
    return YES;
}

#pragma mark - Ohter

- (void)showLoading
{
    [self showLoadingWithMessage:kGDLoadingText];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)checkVersionInfo{
    
   
}

- (void)showHomeVC{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"enterBackground" object:nil];
    TEST_DEALLOC;
}


@end
