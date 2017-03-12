//
//  FoodViewController.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodCell.h"
#import "ReaderViewController.h"

@interface FoodViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.title = @"儿童饮食";
    self.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.68 blue:0.38 alpha:1];
    NSString * str[18] = {@"五彩冬瓜盅", @"土豆粥", @"小米山药粥", @"米仁荸荠", @"米粉鸡肉", @"芦根二仁粥", @"虾皮紫菜蛋汤", @"豌豆瓣咖喱粉汤", @"香肠炒蛋"};
    _dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<9; i++) {
        [_dataArray addObject:str[i]];
    }
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH-40) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:0.87 green:0.68 blue:0.38 alpha:1];
    [self.view addSubview:tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screenH-64-49)/3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil)
    {
        cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    
    cell.tag = indexPath.row;
    [cell.food1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.food2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.food3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.food1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_dataArray objectAtIndex:indexPath.row*3]]] forState:UIControlStateNormal];
    [cell.food2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_dataArray objectAtIndex:indexPath.row*3+1]]] forState:UIControlStateNormal];
    [cell.food3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_dataArray objectAtIndex:indexPath.row*3+2]]] forState:UIControlStateNormal];
    
    return cell;
}

- (void)buttonClick:(UIButton*)button
{
    ReaderViewController *readerVC = [[ReaderViewController alloc] init];
    
    FoodCell * cell = (FoodCell*)[button superview];
    NSInteger i = cell.tag;
    NSInteger j = button.tag;
    NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[_dataArray objectAtIndex:i*3+j-1] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

    readerVC.title = [_dataArray objectAtIndex:i*3+j-1];
    readerVC.textview.text = str;
    
    [readerVC setHidesBottomBarWhenPushed:YES];
  
    readerVC.totalPage = readerVC.textview.contentSize.height/(screenH-64-40);
    readerVC.numpages.text = [NSString stringWithFormat:@"%.0f/%.0f",readerVC.currentPage, readerVC.totalPage];
    [self.navigationController pushViewController:readerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
