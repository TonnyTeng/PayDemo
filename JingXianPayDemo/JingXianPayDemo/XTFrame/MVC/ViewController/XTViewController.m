//
//  XTViewController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTViewController.h"

@interface XTViewController ()

@end

@implementation XTViewController

- (void)dealloc
{
    TEST_DEALLOC;
}

- (UIViewController *)previousViewController
{
    if (self.navigationController)
    {
        NSArray *viewControllers = self.navigationController.viewControllers;
        NSInteger count = [viewControllers count];
        if (count >= 2)
        {
            UIViewController *previousViewController = [viewControllers objectAtIndex: count - 2];
            return previousViewController;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DDLogInfo(@"=========内存不足=========%@",[self class]);
}

@end
