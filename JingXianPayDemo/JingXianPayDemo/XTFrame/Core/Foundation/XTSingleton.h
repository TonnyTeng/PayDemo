//
//  XTSingleton.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ \
__singleton__ = [[__class alloc] init]; \
} ); \
return __singleton__; \
}
