//
//  UIImageView+Shadow.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

//http://www.jianshu.com/p/97e582fe89f3
typedef NS_ENUM(NSInteger,ShowShadowType){
    //显示阴影 位置
    DTShowShadowNone   = 0,
    DTShowShadowBottom = 1<<0,//底部
    DTShowShadowRight  = 1<<1,//右侧
    DTShowShadowLeft   = 1<<2,//左侧
    DTShowShadowTop    = 1<<3,//顶部
};

@interface UIImageView (Shadow)

- (void)showShadowWithType:(ShowShadowType)type shadowColor:(UIColor *)color;

@end
