//
//  ABCBackView.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ABCBackView.h"
@implementation ABCBackView

- (id)initWithFrame:(CGRect)frame WithTag:(NSInteger)tag AndImageName:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 50, 50);
        button.tag=tag;
        [button addTarget:self action:@selector(speakLetter:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
    }
    return self;
}

-(void)moveTo:(CGRect)fram after:(NSTimeInterval)delayTime{
    [UIView beginAnimations:@"moveTo" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:delayTime];
    [UIView setAnimationDuration:1.0];
    self.frame =fram;
    [UIView commitAnimations];
}

-(void)speakLetter:(id)sender{
    UIButton *button = (id)sender;
    mediaPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"abc%ld.mp3",(long)button.tag]]]];
    mediaPlayer.moviePlayer.shouldAutoplay = YES;
    [mediaPlayer.moviePlayer play];
}

@end
