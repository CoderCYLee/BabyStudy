//
//  MusicListViewController.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicBoxViewController.h"
#import "Music.h"

@interface MusicListViewController ()

@end

@implementation MusicListViewController
@synthesize musicBoxViewController;
@synthesize music;
@synthesize MusicBox;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)musicCode
{
    Music *music1 = [[Music alloc] initWithMusicName:@"小叮当" andMusicType:@"mp3"];
    Music *music2 = [[Music alloc] initWithMusicName:@"让我们荡起双桨" andMusicType:@"mp3"];
    Music *music3 = [[Music alloc] initWithMusicName:@"儿童歌曲-两只老虎" andMusicType:@"mp3"];
    Music *music4 = [[Music alloc] initWithMusicName:@"彩虹糖的梦" andMusicType:@"mp3"];
    Music *music5 = [[Music alloc] initWithMusicName:@"卖报歌" andMusicType:@"mp3"];
    Music *music6 = [[Music alloc] initWithMusicName:@"泥娃娃" andMusicType:@"mp3"];
    Music *music7 = [[Music alloc] initWithMusicName:@"采蘑菇的小姑娘" andMusicType:@"mp3"];
    Music *music8 = [[Music alloc] initWithMusicName:@"小燕子" andMusicType:@"mp3"];
    Music *music9 = [[Music alloc]initWithMusicName:@"小小葫芦娃" andMusicType:@"mp3"];
    Music *music10 = [[Music alloc]initWithMusicName:@"大西瓜" andMusicType:@"mp3"];
    Music *music11 = [[Music alloc]initWithMusicName:@"娃哈哈" andMusicType:@"mp3"];
    Music *music12 = [[Music alloc]initWithMusicName:@"小龙人" andMusicType:@"mp3"];
    Music *music13 = [[Music alloc]initWithMusicName:@"白龙马" andMusicType:@"mp3"];
    Music *music14 = [[Music alloc]initWithMusicName:@"花仙子" andMusicType:@"mp3"];
    Music *music15 = [[Music alloc]initWithMusicName:@"黑猫警长" andMusicType:@"mp3"];
    Music *music16 = [[Music alloc] initWithMusicName:@"机器猫" andMusicType:@"mp3"];
    Music *music17 = [[Music alloc] initWithMusicName:@"拔萝卜" andMusicType:@"mp3"];
    Music *music18 = [[Music alloc] initWithMusicName:@"火车开了" andMusicType:@"mp3"];
    
    [MusicBox addObject:music1];
    [MusicBox addObject:music2];
    [MusicBox addObject:music3];
    [MusicBox addObject:music4];
    [MusicBox addObject:music5];
    [MusicBox addObject:music6];
    [MusicBox addObject:music7];
    [MusicBox addObject:music8];
    [MusicBox addObject:music9];
    [MusicBox addObject:music10];
    [MusicBox addObject:music11];
    [MusicBox addObject:music12];
    [MusicBox addObject:music13];
    [MusicBox addObject:music14];
    [MusicBox addObject:music15];
    [MusicBox addObject:music16];
    [MusicBox addObject:music17];
    [MusicBox addObject:music18];
}

- (void)createUI
{
    self.title = @"音乐";
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"musicbg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"正在播放" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(btnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTintColor:[UIColor orangeColor]];
    rightButton.frame = CGRectMake(1, 0, 60, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = item;
    
    // 类似官方桌面的背景的可移动性
    // x轴，水平方向移动
    UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:-40.0];
    xEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
    [imageView addMotionEffect:xEffect];
    // y轴，竖直方向移动
    UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yEffect.minimumRelativeValue = [NSNumber numberWithFloat:-40.0];
    yEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
    [imageView addMotionEffect:yEffect];
    
    musicBoxViewController = [[MusicBoxViewController alloc] initWithNibName:@"MusicBoxViewController" bundle:nil];
    
    MusicBox = [[NSMutableArray alloc] init];
    mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH-64-49) style:UITableViewStylePlain];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    mytableview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mytableview];
    
    [self musicCode];
}

- (void)btnItemClick:(UIButton *)button
{
    musicBoxViewController.running = YES;
    [self.navigationController pushViewController:musicBoxViewController animated:YES];
}

-(void)downloadmusic:(id)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MusicBox.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [[NSBundle mainBundle] loadNibNamed:@"tableCell" owner:self options:nil];
        cell = tableViewCell;
        cell.opaque = NO;//opaque不透明的，NO为透明的
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"activity_dragonball_spot%d", arc4random()%5+1]];
    Music *tmp = MusicBox[indexPath.row];
    UILabel *musicLable = (UILabel*)[cell viewWithTag:1];
    musicLable.backgroundColor = [UIColor clearColor];
    musicLable.text = tmp.musicName;
    UILabel *typeLable = (UILabel*)[cell viewWithTag:2];
    typeLable.backgroundColor = [UIColor clearColor];
    typeLable.text = tmp.musicType;
    UILabel *testLable = (UILabel*)[cell viewWithTag:3];
    testLable.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    music = MusicBox[indexPath.row];
    musicBoxViewController.music = music;
    musicBoxViewController.MusicBox = MusicBox;
    musicBoxViewController.running = NO;
    [self.navigationController pushViewController:musicBoxViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
