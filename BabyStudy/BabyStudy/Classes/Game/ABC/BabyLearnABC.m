//
//  BabyLearnABC.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "BabyLearnABC.h"
#import <QuartzCore/QuartzCore.h>
#define kDuration 0.7  
#import "MediaPlayer/MediaPlayer.h"
#import "ABCBackView.h"
@implementation BabyLearnABC
@synthesize menu=_menu;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"音乐开关" style:UIBarButtonItemStylePlain target:self action:@selector(button_click)];
        
        self.title = @"跟我学英语字母";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    imageview.image=[UIImage imageNamed:@"background7.png"];
    imageview.clipsToBounds = YES;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageview];
    [self beginDH];
    NSString *url = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"abcsong.mp3"];
    mediaPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:url]];
    mediaPlayer.moviePlayer.shouldAutoplay = YES;
    [mediaPlayer.moviePlayer play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *onetouch=[touches anyObject];
    if(onetouch.tapCount==1)
    {
        self.navigationController.navigationBarHidden = YES;
    }
    else if(onetouch.tapCount==2)
    {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)hide
{
    [self.menu removeFromSuperview];
    self.menu = nil;
}

-(void)button_click
{
    if (self.menu == nil) {
        self.menu = [[PopoverView alloc] initWithFrame:CGRectMake(screenW-100, 50, 100, 80)];
        [self.menu setImage:[UIImage imageNamed:@"menu"]];
        self.menu.delegate = self;
        [self.navigationController.view addSubview:self.menu];
        [self.menu addMenuItem:@"开"];
        [self.menu addMenuItem:@"关"];
        [UIView animateWithDuration:0.3 animations:^(void) {
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
        [mediaPlayer.moviePlayer play];
    }
    else if(index==1)
    {
        [mediaPlayer.moviePlayer stop];
    }
    [self hide];
}

-(void)beginDH
{
    CGFloat w = 40;
    CGFloat h = w;

    CGFloat marginX = (screenW - w*4)/5;
    CGFloat marginY = (screenH - h*7)/8;
    CGFloat cX = marginX;
    CGFloat cY = marginY;
    
    
    for (int i =1; i<=26; i++) {
        ABCBackView *abcBack = [[ABCBackView alloc]initWithFrame:CGRectMake(-50,-50,40,40) WithTag:i AndImageName:[NSString stringWithFormat:@"blue-crystal-%d-letter.gif",i]];
        
        if(i==1)
        {
            [abcBack moveTo:CGRectMake(cX, cY, w, h) after:6.0];
        }
        else if(i>1 & i<=4){
            [abcBack moveTo:CGRectMake((i-1)*marginX+cX+(i-1)*w, cY, w, h) after:6.0+0.3*i];
        }else if(i>4 & i<=8){
            if(i==8) {
                [abcBack moveTo:CGRectMake((i-5)*marginX+cX+(i-5)*w, cY+h+marginY, w, h) after:7.8+0.15*i];
            } else {
                [abcBack moveTo:CGRectMake((i-5)*marginX+cX+(i-5)*w,cY+h+marginY, w, h) after:6.0+0.3*i];
            }
            
        } else if(i>8 & i<=12) {
            [abcBack moveTo:CGRectMake((i-9)*marginX+cX+(i-9)*40, cY+(h+marginY)*2, w, h) after:7.8+0.15*i];
        } else if(i>12 & i<=16) {
            [abcBack moveTo:CGRectMake((i-13)*marginX+cX+(i-13)*w,cY+(h+marginY)*3, w, h) after:7.8+0.15*i];
        } else if(i>16 & i<=20) {
            [abcBack moveTo:CGRectMake((i-17)*marginX+cX+(i-17)*w,cY+(h+marginY)*4, w, h) after:7.0+0.3*i];
        } else if(i>20 & i<=24) {
            
            if(i==21) {
                [abcBack moveTo:CGRectMake((i-21)*marginX+cX+(i-21)*w, cY+(h+marginY)*5, w, h) after:7.0+0.3*i];
            }
            else if(i==22) {
                [abcBack moveTo:CGRectMake((i-21)*marginX+cX+(i-21)*w, cY+(h+marginY)*5, w, h) after:7.0+0.3*i];
            }
            else {
            [abcBack moveTo:CGRectMake((i-21)*marginX+cX+(i-21)*w, cY+(h+marginY)*5, w, h) after:3.0+0.5*i];
            }
            
        } else if(i>24 & i<=26) {
            [abcBack moveTo:CGRectMake((i-25)*marginX+cX+(i-25)*50, cY+(h+marginY)*6, 50, 50) after:3.0+0.5*i];
        }
        
        [self.view addSubview:abcBack];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
