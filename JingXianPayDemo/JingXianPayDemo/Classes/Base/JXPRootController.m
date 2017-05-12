//
//  JXPRootController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPRootController.h"
#import "JXPBaseNavController.h"
#import "JXPLoginController.h"
#import "JXPHomeController.h"
#import "JXPTradingController.h"
#import "JXPAccountController.h"
#import "JXPMoreController.h"

@interface JXPRootController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) XTTabBarController *rootTabBarVC;
@property (nonatomic, strong) JXPHomeController  *homeVC;


@end

@implementation JXPRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.rootTabBarVC.view];
    
}

#pragma mark - Other Method

- (void)setupChildControllers
{
    [self setupChildNavigationControllerWithClass:[JXPBaseNavController class] tabBarImageName:@"" rootViewControllerClass:[JXPHomeController class] rootViewControllerTitle:@"应用中心"];
    
    [self setupChildNavigationControllerWithClass:[JXPBaseNavController class] tabBarImageName:@"" rootViewControllerClass:[JXPTradingController class] rootViewControllerTitle:@"交易记录"];
    
    [self setupChildNavigationControllerWithClass:[JXPBaseNavController class] tabBarImageName:@"" rootViewControllerClass:[JXPAccountController class] rootViewControllerTitle:@"账户管理"];
    [self setupChildNavigationControllerWithClass:[JXPBaseNavController class] tabBarImageName:@"" rootViewControllerClass:[JXPMoreController class] rootViewControllerTitle:@"更多"];
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    JXPBaseController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.rootTabBarVC = self.rootTabBarVC;
    rootVC.title = title;
    if ([title isEqualToString:@"应用中心"]) {
        
        self.homeVC = (JXPHomeController *)rootVC;
    }
    JXPBaseNavController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    [_rootTabBarVC addChildViewController:navVc];
}

#pragma mark - Settter/Gettter
-(XTTabBarController *)rootTabBarVC{

    if (_rootTabBarVC == nil) {
        
        _rootTabBarVC = [[XTTabBarController alloc] init];
        _rootTabBarVC.delegate = self;
        [self setupChildControllers];
    }
    return _rootTabBarVC;
}


#pragma tarbardelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(viewController == [tabBarController.viewControllers objectAtIndex:1] ||
       viewController == [tabBarController.viewControllers objectAtIndex:2] ||
       viewController == [tabBarController.viewControllers objectAtIndex:3]){

        if (CLIENT.user) {
            
            return YES;
        }else{
        
            JXPLoginController *loginVC = [[JXPLoginController alloc] init];
            [self.homeVC.navigationController pushViewController:loginVC animated:YES];
           
            return NO;
        }
        
    }else{
        return YES;
    }
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
