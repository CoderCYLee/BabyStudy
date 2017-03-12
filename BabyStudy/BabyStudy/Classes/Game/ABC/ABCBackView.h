//
//  ABCBackView.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@interface ABCBackView : UIView
{
    MPMoviePlayerViewController *mediaPlayer;
}

- (id)initWithFrame:(CGRect)frame WithTag:(NSInteger)tag AndImageName:(NSString *)name;
- (void)moveTo:(CGRect)fram after:(NSTimeInterval)delayTime;

@end
