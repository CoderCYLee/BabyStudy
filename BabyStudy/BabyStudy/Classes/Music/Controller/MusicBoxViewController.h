//
//  MusicBoxViewController.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Music.h"
#import "PopoverView.h"
@interface MusicBoxViewController : UIViewController<AVAudioPlayerDelegate,PopoverViewDelegate> {
	AVAudioPlayer *audioPlayer;
	UISlider *jindu;  //播放进度条
	UILabel *currentTime;//当前播放时间
	UILabel *endTime;//剩余播放时间
	UILabel *currentBigTime;//当快进或快退时让当前播放时间放大显示
	UISlider *Volomn;//音量控制滑调
	UILabel *sound;//显示音量
	UIButton *playButton;//播放按钮
	UIButton *pauseButton;//暂停按钮
	Music *music;//音乐
	NSTimer *timer;//定时器,记录播放进度条,同步显示播放时间
	int mark;//标记播放模式是随机播放还是单曲循环
	int noter;//记录播放与暂停时的时间

}

@property (nonatomic, assign) BOOL running;


@property(nonatomic, retain) PopoverView *menu;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) IBOutlet UILabel *MusicName;
@property (nonatomic, retain) IBOutlet UISlider *jindu;
@property (nonatomic, retain) IBOutlet UILabel *currentTime;
@property (nonatomic, retain) IBOutlet UILabel *endTime;
@property (nonatomic, retain) UILabel *currentBigTime;
@property (nonatomic, retain) IBOutlet UISlider *Volomn;
@property (nonatomic, retain) IBOutlet UILabel *sound;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *pauseButton;
@property (nonatomic, retain) Music *music;
@property (nonatomic, retain) NSMutableArray *MusicBox;
@property (nonatomic, retain) NSTimer *timer;
- (IBAction)play;//播放音乐
- (IBAction)pause;//音乐暂停
- (IBAction)previousMusic;//播放上一首
- (IBAction)nextMusic;//播放下一首
- (IBAction)jinduChange;//快进或快退
- (void)jinduControl;//记录播放进度
- (void)run;//播放状态
- (IBAction)soundChange;//音量控制
- (void)circlePlay;//单曲循环
-(void)nextplaymusic;
- (void)randomicityPlay;//随机播放
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
- (void)hide;
@end

