//
//  XTThread.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FOREGROUND_BEGIN	[[XTThread sharedInstance] enqueueForeground:^{
#define FOREGROUND_DELAY(x)	[[XTThread sharedInstance] enqueueForegroundWithDelay:(dispatch_time_t)x block:^{
#define FOREGROUND_COMMIT	}];

#define BACKGROUND_BEGIN	[[XTThread sharedInstance] enqueueBackground:^{
#define BACKGROUND_DELAY(x)	[[XTThread sharedInstance] enqueueBackgroundWithDelay:(dispatch_time_t)x block:^{
#define BACKGROUND_COMMIT	}];

@interface XTThread : NSObject
{
    dispatch_queue_t _foreQueue;
    dispatch_queue_t _backQueue;
}

//AS_SINGLETON( XTThread );

- (dispatch_queue_t)foreQueue;
- (dispatch_queue_t)backQueue;

- (void)enqueueForeground:(dispatch_block_t)block;
- (void)enqueueBackground:(dispatch_block_t)block;
- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;
- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

@end
