//
//  StoryViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "StoryViewController.h"
#import "DetailViewController.h"

@interface StoryViewController ()<UIScrollViewDelegate>
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation StoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"故事";
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.68 blue:0.38 alpha:1];
    
    [self.view addSubview:self.scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)button_click:(UIButton *)button
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.newtag = button.tag;
    CYLog(@"%ld", (long)detailVC.newtag);
    detailVC.running = NO;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.dataArray = [[NSMutableArray alloc] initWithObjects:@"小青蛙听故事", @"老鼠,小鸟和香肠", @"五颗豌豆", @"奖品", @"女娲造人", @"天神的哑水", @"三头公牛和狮子", @"淘淘的愿望", @"天女散花", @"丑小鸭", @"小红帽", @"两头驴子", @"毛驴与主人", @"四个朋友", @"讲礼貌", @"没法通过", @"朋友再见", @"彼得▪潘", nil];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        _scrollView.delegate=self;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(screenW, 200*6);
        
        for(int i=0; i<6; i++) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200*i, screenW, 200)];
            imageview.image = [UIImage imageNamed:@"BookShelfCell@2x.png"];
            [_scrollView addSubview:imageview];
        }
        
        for(int j=0;j<6;j++) {
            for(int k=0;k<3;k++) {
                CGFloat w = 100;
                CGFloat h = 130;
                CGFloat margin = (screenW - 3*w) * 0.25;
                CGFloat x = (margin+w)*k + margin;
                CGFloat y = (j*20+j*180)+10;
                
                UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
                imageview1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",j*3+k+1]];
                [_scrollView addSubview:imageview1];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(x, y, w, h);
                button.alpha = 0.02;
                [button addTarget:self action:@selector(button_click:) forControlEvents:UIControlEventTouchUpInside];
                
                button.tag = j*3+k+1;
                [_scrollView addSubview:button];
                
                NSString *str1 = [self.dataArray objectAtIndex:j*3+k];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, (j*20+j*180)+140, w, 50)];
                label.text = str1;
                label.textColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:1];
                label.textAlignment = NSTextAlignmentCenter;
                label.numberOfLines = 0;
                label.font = [UIFont systemFontOfSize:17];
                label.backgroundColor = [UIColor clearColor];
                [_scrollView addSubview:label];
            }
        }
    }
    return _scrollView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
