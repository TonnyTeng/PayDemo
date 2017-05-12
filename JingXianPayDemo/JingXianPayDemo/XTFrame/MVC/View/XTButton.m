//
//  XTButton.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTButton.h"

#import <objc/runtime.h>

@implementation XTButton

@synthesize normalBackgroundColor = _normalBackgroundColor;
@synthesize highLightBackgroundColor = _highLightBackgroundColor;

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    if (_normalBackgroundColor != normalBackgroundColor) {
        _normalBackgroundColor = normalBackgroundColor;
        self.backgroundColor = normalBackgroundColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.05 animations:^{
        // 高亮时
        if (self.highlighted && _highLightBackgroundColor) {
            self.backgroundColor = _highLightBackgroundColor;
        }
        // 取消高亮
        else if (self.highlighted == NO && _normalBackgroundColor) {
            self.backgroundColor = _normalBackgroundColor;
        }
    }];
}

@end
