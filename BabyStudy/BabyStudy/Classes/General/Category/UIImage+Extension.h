//
//  UIImage+Extension.h
//  WeiFantasy
//
//  Created by cyrill on 15/3/27.
//  Copyright (c) 2015年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)resizedImage:(NSString *)name;
@end
