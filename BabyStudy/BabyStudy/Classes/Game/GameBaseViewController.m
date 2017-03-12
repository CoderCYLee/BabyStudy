//
//  GameBaseViewController.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GameBaseViewController.h"
#import "BabyLearnABC.h"

@interface GameBaseViewController ()

@end

@implementation GameBaseViewController

@synthesize menu = _menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"音乐开关" style:UIBarButtonItemStylePlain target:self action:@selector(button_click)];
        self.title=@"快乐学习";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    // timechanged = YES;
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    imageview.image = [UIImage imageNamed:@"yd4"];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageview];
    
    // 类似官方桌面的背景的可移动性
    // x轴，水平方向移动
    UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:-40.0];
    xEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
    [imageview addMotionEffect:xEffect];
    // y轴，竖直方向移动
    UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yEffect.minimumRelativeValue = [NSNumber numberWithFloat:-40.0];
    yEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
    [imageview addMotionEffect:yEffect];
    
    mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, 460-44) style:UITableViewStyleGrouped];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    mytableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mytableview];
    
    array = [[NSMutableArray alloc] initWithObjects:@"摘西瓜",@"跟我学英语字母",nil];
    array1 = [[NSMutableArray alloc] initWithObjects:@"此应用是以游戏形式学习数学",@"此应用快乐学习英语字母",nil];
    
    imagesarray = [[NSMutableArray alloc]initWithObjects:@"shanguang-a@2x.png",@"shanguang-a@2x.png",nil];
    
    [self loadMusic:@"gangqinbg" type:@"mp3"];
    
    [self timechanged_click];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timechanged_click) userInfo:nil repeats:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:0.4];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

#pragma mark - cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellName = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellName];
    if(cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellName];
    }
    
    cell.textLabel.text=[array objectAtIndex:indexPath.section];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text=[array1 objectAtIndex:indexPath.section];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    if (indexPath.section == 0) {
        cell.imageView.image=[UIImage imageNamed:@"xg"];
    } else if (indexPath.section == 1) {
        cell.imageView.image=[UIImage imageNamed:@"abcIcon"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        timechanged = NO;
        [self timechanged_click];
        MathViewController *mathviewcontroller=[[MathViewController alloc]initWithNibName:@"MathViewController" bundle:nil];
        [mathviewcontroller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:mathviewcontroller animated:YES];
    } else if(indexPath.section == 1) {
        timechanged = NO;
        [self timechanged_click];
        BabyLearnABC *abc = [[BabyLearnABC alloc]init];
        [abc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:abc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        self.menu.backgroundColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:0.4];
        self.menu.delegate = self;
        [self.navigationController.view addSubview:self.menu];
        [self.menu addMenuItem:@"开"];
        [self.menu addMenuItem:@"关"];
        [UIView animateWithDuration:.3 animations:^(void) {
            self.menu.alpha = 1;
        }];
    } else {
        [self hide];
    }
}

- (void)popoverView:(PopoverView *)popoverView selectedAtIndex:(int)index
{
    if (index == 0) {
//        timechanged = YES;
//        [self timechanged_click];
        [_audioPlayer play];
    }
    else if(index == 1)
    {
//        timechanged = NO;
//        [self timechanged_click];
        [_audioPlayer stop];
    }
    [self hide];
}


-(void)timechanged_click
{
    if(timechanged == YES) {
        [_audioPlayer play];
    } else {
        [_audioPlayer stop];
    }
}

-(void)loadMusic:(NSString*)name type:(NSString*)type
{
    NSString* path = [[NSBundle mainBundle] pathForResource: name ofType:type];
    NSURL* url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audioPlayer.delegate = self;
    _audioPlayer.volume = 0.5;
    [_audioPlayer prepareToPlay];
    [self timechanged_click];
}

@end
