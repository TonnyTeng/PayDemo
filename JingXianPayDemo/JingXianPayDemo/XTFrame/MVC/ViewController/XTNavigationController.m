//
//  XTNavigationController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTNavigationController.h"

@interface XTNavigationController ()

@end

@implementation XTNavigationController

- (void)dealloc
{
    TEST_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DDLogInfo(@"=========内存不足=========%@",[self class]);
}

@end
