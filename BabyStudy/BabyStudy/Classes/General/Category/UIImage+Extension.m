//
//  UIImage+Extension.m
//  WeiFantasy
//
//  Created by cyrill on 15/3/27.
//  Copyright (c) 2015年 Coder. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
