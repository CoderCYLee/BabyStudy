//
//  ThinkViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ThinkViewController.h"

@interface ThinkViewController ()

@end

@implementation ThinkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"脑筋急转弯";
    self.totalPage = 34;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = [UIImage imageNamed:@"readbg"];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:imageView];
        
        self.textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-40-64)];
        
        self.textview.editable = NO;
        self.textview.backgroundColor = [UIColor lightTextColor];
        self.textview.font = [UIFont systemFontOfSize:20];
        self.textview.pagingEnabled = YES;
        self.numpages = [[UILabel alloc]initWithFrame:CGRectMake(0, screenH-40 , screenW, 40)];
        self.numpages.textAlignment = NSTextAlignmentCenter;
        self.numpages.backgroundColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:0.7];
        self.numpages.textColor = [UIColor whiteColor];

        [self.view addSubview:self.textview];
        [self.view addSubview:self.numpages];
        [self.view addSubview:_button1];
        [self.view addSubview:_button2];
        
        self.textview.delegate = self;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentPage = self.textview.contentOffset.y/(screenH-40);
    
    self.numpages.text = [NSString stringWithFormat:@"%.0f/%.0f",self.currentPage,self.totalPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
