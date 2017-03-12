//
//  MusicBoxViewController.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MusicBoxViewController.h"

@implementation MusicBoxViewController
@synthesize menu;
@synthesize audioPlayer;
@synthesize MusicName;
@synthesize jindu;
@synthesize currentTime;
@synthesize endTime;
@synthesize currentBigTime;
@synthesize Volomn;
@synthesize sound;
@synthesize playButton;
@synthesize pauseButton;
@synthesize music;
@synthesize MusicBox;
@synthesize timer;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	pauseButton.hidden=YES;
	currentBigTime.hidden=YES;
    [UIView animateWithDuration:1.0 animations:^{
        self.navigationController.navigationBarHidden = YES;
        self.navigationController.navigationBar.alpha = 0;
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"播放类型" style:UIBarButtonItemStylePlain target:self action:@selector(button_click)];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    if (self.running == NO) {
        [self play];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *onetouch=[touches anyObject];
    if(onetouch.tapCount==1)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBarHidden = YES;

        }];
        
    }
    else if(onetouch.tapCount==2)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.navigationBar.alpha = 1;
        }];
    }
}

- (void)hide
{
    [self.menu removeFromSuperview];
    
    [self.menu.buttons removeAllObjects];
    
    self.menu = nil;
}

-(void)button_click
{
    if (self.menu == nil) {
        
        self.menu = [[PopoverView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 50, 100, 80)];

        self.menu.delegate = self;
        [self.navigationController.view addSubview:self.menu];
        [self.menu addMenuItem:@"随机播放"];
        [self.menu addMenuItem:@"单曲循环"];
        [self.menu addMenuItem:@"多曲循环"];
        self.menu.backgroundColor=[UIColor clearColor];
        
        [UIView animateWithDuration:.3 animations:^(void) {
            self.menu.alpha = 1;
        }];
    }
    else
    {
        [self hide];
    }
}

- (void)popoverView:(PopoverView *)popoverView selectedAtIndex:(int)index
{
    if (index == 0) {
        [self randomicityPlay];
    }
    else if(index==1)
    {
        [self circlePlay];
    }
    else if(index==2)
    {
        [self nextplaymusic];
    }
    [self hide];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark 歌曲基本功能
- (IBAction)play
{
	self.title=music.musicName;
	MusicName.text=music.musicName;//播放的同时显示相应的歌曲名称
	NSString *path=[[NSBundle mainBundle]pathForResource:music.musicName ofType:music.musicType];
	NSError *error;
	NSURL *url=[NSURL fileURLWithPath:path];

    
    
//    NSURL *url = [NSURL URLWithString:@"http://omoxjlk85.bkt.clouddn.com/9%20The%20starts%20shine.mp3"];
//    
//    NSData *audioData = [NSData dataWithContentsOfURL:url];
//    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"1"];
//    [audioData writeToFile:filePath atomically:YES];
//    
//    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
	audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
//    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    
	audioPlayer.numberOfLoops=0;//0为单曲播放,1循环播放
	audioPlayer.delegate=self;//设置回调方法的委托
	if(audioPlayer==nil)
	{
		CYLog(@"error is %@",error);
	}
	else
	{
		if(noter==0)
		{
			[audioPlayer play];
		}
		else
		{
			audioPlayer.currentTime=noter;
			[audioPlayer play];
		}
	}
	playButton.hidden=YES;
	pauseButton.hidden=NO;
	[self jinduControl];
}

//暂停
- (IBAction)pause
{
	noter=audioPlayer.currentTime;
	playButton.hidden=NO;
	pauseButton.hidden=YES;
	[audioPlayer pause];
}

//停止,重新选择或重新播放
- (IBAction)stop
{
	playButton.hidden=NO;
	pauseButton.hidden=YES;
	noter=0;
	[jindu setValue:noter];
	currentTime.text = @"0.0";
	endTime.text = @"0.0";
	[audioPlayer stop];
	audioPlayer=nil;
}

//播放上一首
- (IBAction)previousMusic
{
	if(music)
	{
		[self stop];
		NSInteger index = [MusicBox indexOfObject:music];
		if(index!=0 && index<[MusicBox count])
		{
			music=[MusicBox objectAtIndex:(index-1)];
		}
		else if(index==0)
		{
			music=[MusicBox objectAtIndex:([MusicBox count]-1)];
		}
	}
	else
	{
		music=[MusicBox objectAtIndex:([MusicBox count]-1)];
	}
	[self play];
}

//播放下一首
- (IBAction)nextMusic
{
	if(music)
	{
		[self stop];
		NSInteger index = [MusicBox indexOfObject:music];
		if(index<([MusicBox count]-1))
		{
			music=[MusicBox objectAtIndex:(index+1)];
		}
		else if(index==([MusicBox count]-1))
		{
			music=[MusicBox objectAtIndex:0];
		}
	}
	else
	{
		music=[MusicBox objectAtIndex:0];
	}
	[self play];
}

//拖动进度条控制快进或快退
- (IBAction)jinduChange
{
	[audioPlayer stop];
	audioPlayer.currentTime=jindu.value;
	currentTime.hidden=YES;
	currentBigTime.hidden=NO;
	int minutes=floor(jindu.value/60);
	int seconds=round(jindu.value-minutes*60);
	currentBigTime.text=[NSString stringWithFormat:@"%d.%d",minutes,seconds];
	[audioPlayer play];
}

//进度控制，通过定时器控制歌曲播放时间
- (void)jinduControl
{
	[jindu setMinimumValue:0.0];
	[jindu setMaximumValue:audioPlayer.duration];
	if(!timer)
	{
		timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run) userInfo:nil repeats:YES];		
	}
}

//播放状态
- (void)run
{
	currentTime.hidden=NO;
	currentBigTime.hidden=YES;
	if(playButton.hidden==YES)
	{
		[jindu setValue:audioPlayer.currentTime];
		int minutes=floor(audioPlayer.currentTime/60);
		int seconds=round(audioPlayer.currentTime-minutes*60);
		currentTime.text=[NSString stringWithFormat:@"%d.%d",minutes,seconds];
		float end=audioPlayer.duration-audioPlayer.currentTime;
		int endMinutes=floor(end/60);
		int endSeconds=round(end-endMinutes*60);
		endTime.text=[NSString stringWithFormat:@"-%d.%d",endMinutes,endSeconds];
	}
}

//音量控制
- (IBAction)soundChange
{
	int tmp=Volomn.value;
	sound.text=[NSString stringWithFormat:@"%d",tmp];	
	audioPlayer.volume=tmp/100.0;
}

//单曲循环播放
- (void)circlePlay
{
	mark=1;
	noter=audioPlayer.currentTime;
	[self play];
}

//随机播放歌曲
- (void)randomicityPlay
{
	noter=audioPlayer.currentTime;
	[self play];
	mark=2;
	int tmp=rand()%([MusicBox count]);
	CYLog(@"随机数 is %d",tmp);
	Music *tmpMusic=[MusicBox objectAtIndex:tmp];
	music=tmpMusic;
}
//多曲播放
-(void)nextplaymusic
{
    mark=3;
    noter=audioPlayer.currentTime;
	[self play];
}

//当当前歌曲播放结束后进行回调
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	if(mark==1)
	{
		[self circlePlay];
	}
	else if(mark==2)
	{
		[self randomicityPlay];
	}
	else
	{
		[self nextMusic];
	}
}
@end
