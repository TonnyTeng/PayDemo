//
//  UIColor+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#undef	RGB
#define RGB(R,G,B)          [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#undef	RGBA
#define RGBA(R,G,B,A)       [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef	HEX_RGB
#define HEX_RGB(V)          [UIColor fromHexValue:V]

#undef	HEX_RGBA
#define HEX_RGBA(V, A)      [UIColor fromHexValue:V alpha:A]

#undef	HEX_RGB_STRING
#define HEX_RGB_STRING(V)   [UIColor hexString:V]


@interface UIColor (XT)

+ (UIColor *)fromHexValue:(NSUInteger)hex;
+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;
+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorHexString:(NSString *)hex;

@end

#endif
