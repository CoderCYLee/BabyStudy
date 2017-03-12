//
//  AudioTool.h
//  BabyStudy
//
//  Created by cyrill on 15/4/7.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject
/**
 *播放音乐文件
 */
+(BOOL)playMusic:(NSString *)filename;
/**
 *暂停播放
 */
+(void)pauseMusic:(NSString *)filename;
/**
 *播放音乐文件
 */
+(void)stopMusic:(NSString *)filename;

/**
 *播放音效文件
 */
+(void)playSound:(NSString *)filename;
/**
 *销毁音效
 */
+(void)disposeSound:(NSString *)filename;
@end
