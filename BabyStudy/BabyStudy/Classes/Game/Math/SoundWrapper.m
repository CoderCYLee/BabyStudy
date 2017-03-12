//
//  CoolMathAppDelegate.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SoundWrapper.h"
@implementation SoundWrapper

+ (id)soundEffectWithContentsOfFile: (NSString *)aPath 
{
    if (aPath) {
        return [[SoundWrapper alloc] initWithContentsOfFile:aPath];
    }
    return nil;
}

- (id)initWithContentsOfFile: (NSString *)path 
{
    self = [super init];
    if (self != nil) {
        NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        if (aFileURL != nil) {
            SystemSoundID aSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)aFileURL, &aSoundID);
            
            if (error == kAudioServicesNoError) { // success
                _soundID = aSoundID;
            } else {
                self = nil;
            }
        } else {
            self = nil;
        }
    }
    return self;
}

- (void)play {
    AudioServicesPlaySystemSound(_soundID);
}
@end
