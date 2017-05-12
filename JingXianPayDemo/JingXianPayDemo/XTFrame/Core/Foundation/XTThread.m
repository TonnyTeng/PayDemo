//
//  XTThread.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTThread.h"

@implementation XTThread

- (id)init
{
    self = [super init];
    if ( self )
    {
        _foreQueue = dispatch_get_main_queue();
        _backQueue = dispatch_queue_create( "com.xt.taskQueue", nil );
    }
    
    return self;
}

- (dispatch_queue_t)foreQueue
{
    return _foreQueue;
}

- (dispatch_queue_t)backQueue
{
    return _backQueue;
}

- (void)enqueueForeground:(dispatch_block_t)block
{
    dispatch_async( _foreQueue, block );
}

- (void)enqueueBackground:(dispatch_block_t)block
{
    dispatch_async( _backQueue, block );
}

- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _foreQueue, block );
}

- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _backQueue, block );
}

@end
