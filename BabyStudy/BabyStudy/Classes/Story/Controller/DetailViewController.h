//
//  DetailViewController.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DetailViewController : UIViewController<AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int a;
    UIImageView * rootImageView;
    AVAudioPlayer *_audioPlayer;
    NSMutableArray * _pNames;
    NSMutableArray *_hNames;
    
    int _songIndex;
    UIButton * leftButton;
    UIButton * rightButton;
    
    UILabel *_label;
    UISlider * _slider;
    UISlider * _volumeSlider;
    NSTimer * processTimer;
    NSTimer * timer1;
}

@property (nonatomic, assign) BOOL running;
@property int a;
@property(nonatomic,assign)NSInteger newtag;
/** 雪花 */
- (void)snow;
/** 加载音乐 */
- (void)loadMusic:(NSString*)name type:(NSString*)type;
/** 设置背景 */
- (void)setBackground:(UIImage*)image;
/** 播放 */
- (void)play:(UIButton*)button;
@end
