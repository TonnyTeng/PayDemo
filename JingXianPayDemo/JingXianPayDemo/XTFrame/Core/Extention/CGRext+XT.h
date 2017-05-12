//
//  CGRext+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//


CGSize	AspectFitSizeByWidth( CGSize size, CGFloat width );
CGSize	AspectFitSizeByHeight( CGSize size, CGFloat height );

CGSize	AspectFitSize( CGSize size, CGSize bound );
CGRect	AspectFitRect( CGRect rect, CGRect bound );

CGSize	AspectFillSize( CGSize size, CGSize bound );
CGRect	AspectFillRect( CGRect rect, CGRect bound );

CGRect	CGRectFromString( NSString * str );

CGPoint	CGPointZeroNan( CGPoint point );
CGSize	CGSizeZeroNan( CGSize size );
CGRect	CGRectZeroNan( CGRect rect );

CGRect	CGRectAlignX( CGRect rect1, CGRect rect2 );				// rect1向rect2的X轴中心点对齐
CGRect	CGRectAlignY( CGRect rect1, CGRect rect2 );				// rect1向rect2的Y轴中心点对齐
CGRect	CGRectAlignCenter( CGRect rect1, CGRect rect2 );		// rect1向rect2的中心点对齐

CGRect	CGRectAlignTop( CGRect rect1, CGRect rect2 );			// 右边缘对齐
CGRect	CGRectAlignBottom( CGRect rect1, CGRect rect2 );		// 下边缘对齐
CGRect	CGRectAlignLeft( CGRect rect1, CGRect rect2 );			// 左边缘对齐
CGRect	CGRectAlignRight( CGRect rect1, CGRect rect2 );			// 上边缘对齐

CGRect	CGRectAlignLeftTop( CGRect rect1, CGRect rect2 );		// 右边缘对齐
CGRect	CGRectAlignLeftBottom( CGRect rect1, CGRect rect2 );	// 下边缘对齐
CGRect	CGRectAlignRightTop( CGRect rect1, CGRect rect2 );		// 右边缘对齐
CGRect	CGRectAlignRightBottom( CGRect rect1, CGRect rect2 );	// 下边缘对齐

CGRect	CGRectCloseToTop( CGRect rect1, CGRect rect2 );			// 与上边缘靠近
CGRect	CGRectCloseToBottom( CGRect rect1, CGRect rect2 );		// 与下边缘靠近
CGRect	CGRectCloseToLeft( CGRect rect1, CGRect rect2 );		// 与左边缘靠近
CGRect	CGRectCloseToRight( CGRect rect1, CGRect rect2 );		// 与右边缘靠近

CGRect	CGRectMoveCenter( CGRect rect1, CGPoint offset );		// 移动中心点
CGRect	CGRectMakeBound( CGFloat w, CGFloat h );

CGRect	CGSizeMakeBound( CGSize size );
CGRect	CGRectToBound( CGRect frame );
