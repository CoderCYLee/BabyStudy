//
//  DetailViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize newtag=_newtag;
@synthesize a;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"故事";
    
    [UIView animateWithDuration:1.0 animations:^{
        self.navigationController.navigationBarHidden = YES;
        self.navigationController.navigationBar.alpha = 0;
    }];
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [lbtn setTitle:@"返回" forState:UIControlStateNormal];
    [lbtn addTarget:self action:@selector(btnItemClick) forControlEvents:UIControlEventTouchUpInside];
    [lbtn setTintColor:[UIColor orangeColor]];
    lbtn.frame = CGRectMake(1, 0, 60, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lbtn];
    self.navigationItem.leftBarButtonItem = item;
    
    [self performSelector:@selector(dataInit)];
    [self performSelector:@selector(viewInit)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)btnItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if(_audioPlayer.playing) {
        [_audioPlayer stop];
    } else {
        
    }
}

- (void)dataInit
{
    a = 0;
    NSString * str[18] = {@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"};
    _pNames = [[NSMutableArray alloc] init];
    for (int i=0; i<18; i++) {
        [_pNames addObject:str[i]];
    }
    _hNames=[[NSMutableArray alloc] initWithObjects:@"小青蛙听故事",@"老鼠,小鸟和香肠",@"五颗豌豆",@"奖品",@"女娲造人",@"天神的哑水",@"三头公牛和狮子",@"淘淘的愿望",@"天女散花",@"丑小鸭",@"小红帽",@"两头驴子",@"驴子与主人",@"四个朋友",@"讲礼貌",@"没法通过",@"朋友再见",@"彼得*潘",nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *onetouch=[touches anyObject];
    if(onetouch.tapCount==1)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBarHidden = YES;
//            self.navigationController.navigationBar.alpha = 0;
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

-(void)viewInit
{
    rootImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    rootImageView.contentMode = UIViewContentModeScaleAspectFill;
    rootImageView.image= [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)self.newtag]];
    _songIndex = (int)self.newtag;
    [self.view addSubview:rootImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, screenH-100, screenW, 100)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    [rootImageView addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((screenW-70)*0.5, screenH-74, 70, 52);
    button.tag = 100;
    [button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((screenW-70)*0.5-56, screenH-63, 36, 30);
    [button addTarget:self action:@selector(prier) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"aboveMusic"] forState:UIControlStateNormal];
    leftButton = button;
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((screenW-70)*0.5+88, screenH-63, 36, 30);
    [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nextMusic"] forState:UIControlStateNormal];
    rightButton=button;
    [self.view addSubview:button];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(20, screenH-200-20, screenW-40, 70)];
    titleView.backgroundColor = [UIColor blackColor];
    titleView.alpha = 0.3;
    [rootImageView addSubview:titleView];
    
    button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(20, screenH-200-20+15, 40, 40);
    [button setImage:[UIImage imageNamed:@"xiaolaba"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showVolume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screenW-65, screenH-200-20+15, 45, 40);
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setBackground) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _label= [[UILabel alloc] initWithFrame:CGRectMake(0, screenH-200, screenW, 30)];
    _label.font= [UIFont systemFontOfSize:25];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor= [UIColor whiteColor];
    _label.numberOfLines = 0;
    _label.text=[_hNames objectAtIndex:self.newtag-1];
    _label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_label];
    
    _slider= [[UISlider alloc] initWithFrame:CGRectMake(20, screenH/5, screenW-40, 5)];
    _slider.maximumValue = 100;
    _slider.minimumValue = 0;
    _slider.value = 0;
    _slider.continuous = NO;
    [_slider addTarget:self action:@selector(processSet:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(processTimerStop) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview: _slider];

    _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, screenH-120, screenW, 5)];
    _volumeSlider.maximumValue = 1;
    _volumeSlider.minimumValue = 0;
    _volumeSlider.value = 0.5;
    [_volumeSlider addTarget:self action:@selector(volumeSet:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_volumeSlider];

    processTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(process) userInfo:nil repeats:YES];
    [self loadMusic:[_pNames objectAtIndex:0] type:@"mp3"];
    UILongPressGestureRecognizer* rightLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rightLongPress:)];
    [rightButton addGestureRecognizer:rightLongPress];

    UILongPressGestureRecognizer* leftLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftLongPress:)];
    [leftButton addGestureRecognizer:leftLongPress];
    
}

- (void)processSet:(UISlider*)slider
{
    processTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(process) userInfo:nil repeats:YES];
    _audioPlayer.currentTime = slider.value/100*_audioPlayer.duration;
    if(_audioPlayer.playing == YES)
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
}

- (void)processTimerStop
{
    [processTimer invalidate];
}

- (void)rightLongPress:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state != UIGestureRecognizerStateBegan)
        return;
    if(_audioPlayer.playing)
    {
        if(_audioPlayer.currentTime > _audioPlayer.duration-5)
            _audioPlayer.currentTime = _audioPlayer.currentTime;
        else
            _audioPlayer.currentTime+=5;
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
    }
}

-(void)leftLongPress:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state != UIGestureRecognizerStateBegan)
        return;
    if(_audioPlayer.playing)
    {
        if(_audioPlayer.currentTime < 5) {
            _audioPlayer.currentTime = 0;
        } else {
            _audioPlayer.currentTime -= 5;
        }
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
    }
}

//雪花函数
- (void)snow
{
    int startX = random()%(int)screenW;
    int endX = random()%(int)screenW;
    int width = random()%25;
    CGFloat time = (random()%100)/10+5;
    CGFloat alp = (random()%9)/10.0+0.1;
    UIImage* image= [UIImage imageNamed:@"snow.png"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame= CGRectMake(startX,-1*width,width,width);
    imageView.alpha=alp;
    [self.view addSubview:imageView];
    [UIView beginAnimations:nil context:(__bridge void *)(imageView)];
    [UIView setAnimationDuration:time];
    if(endX>50&&endX<270)
    {
        imageView.frame= CGRectMake(endX, 270-width/2, width, width);
    }
    else if ((endX>10 && endX<50)||(endX>270 && endX<screenW))
        imageView.frame= CGRectMake(endX, 400-width/2, width, width);
    else
        imageView.frame= CGRectMake(endX, 480, width, width);
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString*)animationID finished:(NSNumber*)finished context:(void *)context
{
    UIImageView *snowView = (__bridge UIImageView *)(context);
    [snowView removeFromSuperview];
}

//封装系统加载函数
- (void)loadMusic:(NSString*)name type:(NSString*)type
{
    NSString* path= [[NSBundle mainBundle] pathForResource: name ofType:type];
    NSURL* url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audioPlayer.delegate=self;
    _audioPlayer.volume= 0.5;
    [_audioPlayer prepareToPlay];
}

//播放完成自动切换
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _songIndex++;
    if(_songIndex == _pNames.count)
        _songIndex = 0;
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    _label.text = [_hNames objectAtIndex:_songIndex];
    [_audioPlayer play];
}

// 音量设置
- (void)volumeSet:(UISlider*)slider
{
    _audioPlayer.volume  = slider.value;
}

- (void)showVolume
{
    _volumeSlider.hidden=NO;
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideVolume) userInfo:nil repeats:NO];
}

- (void)hideVolume
{
    _volumeSlider.hidden=YES;
}

// 歌曲进度
- (void)process
{
    _slider.value= 100*_audioPlayer.currentTime/_audioPlayer.duration;
}

// 播放
- (void)play:(UIButton*)button
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld",(long)self.newtag] ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];

    NSError *err;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    if(_audioPlayer == nil) {
        CYLog(@"%@",err);
    } else {
        if(a==0) {
            [_audioPlayer play];
            [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(snow) userInfo:nil repeats:YES];
            a++;
        } else {
            [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [_audioPlayer pause];
            [timer1 invalidate];
            a--;
        }
    }
    
}

// 上一首
-(void)prier
{
    BOOL playFlag;
    if(_audioPlayer.playing) {
        playFlag=YES;
        [_audioPlayer stop];
    } else {
        playFlag=NO;
    }
    _songIndex--;
    if(_songIndex<0) {
        _songIndex = (int)_pNames.count-1;
    }
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_pNames objectAtIndex:_songIndex]]];
    [self setBackground:image];
    _label.text= [_hNames objectAtIndex:_songIndex];
    if(playFlag==YES) {
        [_audioPlayer play];
    }
}

// 下一首
- (void)next
{
    BOOL playFlag;
    if(_audioPlayer.playing) {
        playFlag = YES;
        [_audioPlayer stop];
    } else {
        playFlag = NO;
    }
    _songIndex++;
    if(_songIndex == _pNames.count) {
        _songIndex = 0;
    }
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_pNames objectAtIndex:_songIndex]]];
    [self setBackground:image];
    _label.text = [_hNames objectAtIndex:_songIndex];
    if(playFlag == YES) {
        [_audioPlayer play];
    }
}

//背景
- (void)setBackground
{
    UIImagePickerController *picker= [[UIImagePickerController alloc] init];
    picker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    rootImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setBackground:(UIImage *)image
{
    rootImageView.image = image;    
}
@end
