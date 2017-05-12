//
//  XTLabel.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTLabel.h"

@implementation XTLabel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //是否更新字体的变化
        self.adjustsFontForContentSizeCategory = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
