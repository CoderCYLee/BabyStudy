//
//  GameBaseViewController.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PopoverView.h"
#import "MathViewController.h"

@interface GameBaseViewController : UIViewController<AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate,PopoverViewDelegate>
{
    BOOL timechanged;
    NSMutableArray *imagesarray;
    NSMutableArray *array1;
    UIImageView *imageview;
    NSMutableArray *array;
    UITableView *mytableview;
    AVAudioPlayer *_audioPlayer;
}
@property(nonatomic, retain) PopoverView *menu;
- (void)hide;
-(void)loadMusic:(NSString*)name type:(NSString*)type;
-(void)timechanged_click;

@end
