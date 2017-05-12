//
//  UIImageView+Shadow.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "UIImageView+Shadow.h"

@implementation UIImageView (Shadow)

- (void)showShadowWithType:(ShowShadowType)type shadowColor:(UIColor *)color{
    
    //    self.layer.shadowColor = color.CGColor;
    //    self.layer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    //    self.layer.shadowRadius = 4;
    
    
    self.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    //通过 & 来判断是否包含:
    if (type & DTShowShadowTop) {
        
        [path moveToPoint:topLeft];
        [path addQuadCurveToPoint:topRight
                     controlPoint:topMiddle];
    }
    if (type & DTShowShadowRight) {
        
        [path moveToPoint:topRight];
        [path addQuadCurveToPoint:bottomRight
                     controlPoint:rightMiddle];
    }
    if (type & DTShowShadowLeft) {
        
        [path moveToPoint:topLeft];
        [path addQuadCurveToPoint:bottomLeft
                     controlPoint:leftMiddle];
    }
    
    if (type & DTShowShadowBottom) {
        
        [path moveToPoint:bottomLeft];
        [path addQuadCurveToPoint:bottomRight
                     controlPoint:bottomMiddle];
    }
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
    
}

@end
