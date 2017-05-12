//
//  XTViewController.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTViewController : UIViewController

//用来判断是否已经显示过
@property(nonatomic, assign) BOOL isViewShowed;

//当前页上一个ViewController
@property(nonatomic,weak) UIViewController *previousViewController;

@end
