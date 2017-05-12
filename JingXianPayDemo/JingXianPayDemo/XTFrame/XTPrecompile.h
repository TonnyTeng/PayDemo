//
//  XTPrecompile.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#ifndef XTPrecompile_h
#define XTPrecompile_h
#import "DDLog.h"

#undef XT_VERSION
#define XT_VERSION

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif


#undef	BLOCK
#define BLOCK(block)                        if(block)block

#undef	RESPONDS
#define RESPONDS(object, method)            (object && [object respondsToSelector:@selector(method)])


#define TEST_DEALLOC    DDLogInfo(@"TestDealloc--->%@",[self class]);

#endif /* XTPrecompile_h */
