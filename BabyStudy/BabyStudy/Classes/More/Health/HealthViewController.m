//
//  HealthViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "HealthViewController.h"
#import "ReaderViewController.h"

@interface HealthViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    self.title = @"儿童健康";
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"感冒咳嗽", @"肺气管炎", @"腹泻消炎", @"用药原则", nil];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH-49)];
    imageView.image= [UIImage imageNamed:@"bgBY"];
    [self.view addSubview:imageView];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-64-49) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.section];
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_dataArray objectAtIndex:indexPath.section]]];
    
    cell.imageView.image = image;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReaderViewController *readerViewController = [[ReaderViewController alloc] init];
    readerViewController.title = _dataArray[indexPath.section];
    NSString *string = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[_dataArray objectAtIndex:indexPath.section] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    readerViewController.textview.text = string;
    [readerViewController setHidesBottomBarWhenPushed:YES];
    
    readerViewController.totalPage = readerViewController.textview.contentSize.height/(screenH-64-40);
    readerViewController.numpages.text = [NSString stringWithFormat:@"%.0f/%.0f",readerViewController.currentPage, readerViewController.totalPage];
    [self.navigationController pushViewController:readerViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
