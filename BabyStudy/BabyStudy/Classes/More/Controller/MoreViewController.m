//
//  MoreViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MoreViewController.h"
#import "HealthViewController.h"
#import "FoodViewController.h"
#import "ThinkViewController.h"
#import "AboutViewController.h"
#import "BabyViewController.h"

@interface MoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更多";

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    imageview.image=[UIImage imageNamed:@"yd2"];

    // 改变图片显示的位置或拉伸等等
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
    
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"脑筋急转弯",@"儿童饮食",@"儿童健康",@"宝宝资讯",@"关于",nil];
    _newsArray=[[NSMutableArray alloc]initWithObjects:@"对开发儿童的大脑非常有帮助",@"对儿童的健康成长有帮助",@"有儿童常见的疾病治疗资料",@"通过网络关注儿童健康",@"关于我们的信息",nil];
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"shanguang-a@2x.png",@"shanguang-a@2x.png",@"shanguang-a@2x.png",@"shanguang-a@2x.png",@"shanguang-a@2x.png",nil];
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH-64-49) style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.section];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [_newsArray objectAtIndex:indexPath.section];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.image=[UIImage imageNamed: [_imageArray objectAtIndex:indexPath.section]];

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:0.4];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0) {
        ThinkViewController *thinkViewController = [[ThinkViewController alloc] init];
        NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[_dataArray objectAtIndex:indexPath.row] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        thinkViewController.textview.text = str;
        thinkViewController.totalPage = 34;
        thinkViewController.numpages.text = [NSString stringWithFormat:@"%.0f/%.0f",thinkViewController.currentPage,thinkViewController.totalPage];
        [thinkViewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:thinkViewController animated:YES];
        
    } else if (indexPath.section==1) {
        FoodViewController * fvc = [[FoodViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    } else if (indexPath.section==2) {
        HealthViewController *healthViewController = [[HealthViewController alloc] init];
        [self.navigationController pushViewController:healthViewController animated:YES];
    } else if (indexPath.section==3) {
        BabyViewController *babyViewController = [[BabyViewController alloc] init];
        [self.navigationController pushViewController:babyViewController animated:YES];
        
    } else if (indexPath.section==4) {
        AboutViewController *aboutViewController =[[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutViewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
