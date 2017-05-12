//
//  UIImage+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (XT)

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;
+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

-(UIImage *)originalImage;

- (UIImage *)rounded;
- (UIImage *)rounded:(CGRect)rect;

- (UIImage *)scaleToSize:(CGSize)size;
+ (UIImage *)scaleImageWithImage:(UIImage *)image dimension:(CGFloat)dimension;
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (UIImage *)imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;

- (UIImage *)stretched;
- (UIImage *)grayscale;

- (UIColor *)patternColor;

+ (UIImage *)stretchableImageNamed:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color;

//从本地添加图片
+ (UIImage *)imageWithContentsOfFileName:(NSString *)name;

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//按比例压缩
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;


#pragma mark -- 使用给定的字符串获得CIImage类型的对象
+ (CIImage *)getImageByString:(NSString *)dataString;
#pragma mark -- 对图像进行清晰处理，很关键！
+ (UIImage *)excludeFuzzyImageFromCIImage: (CIImage *)image size: (CGFloat)size;

@end
