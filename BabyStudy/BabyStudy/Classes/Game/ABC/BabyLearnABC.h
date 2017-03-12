//
//  BabyLearnABC.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import "MediaPlayer/MediaPlayer.h"

@interface BabyLearnABC : UIViewController<PopoverViewDelegate>
{
    MPMoviePlayerViewController *mediaPlayer;
}
@property(nonatomic, retain) PopoverView *menu;
-(void)button_click;
-(void)beginDH;
- (void)hide;
@end
