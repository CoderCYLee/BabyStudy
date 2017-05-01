//
//  ReaderViewController.m
//  BabyStudy
//
//  Created by cyrill on 15/4/2.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ReaderViewController.h"

@interface ReaderViewController ()<UITextViewDelegate>
@property (nonatomic,retain) UIButton * upBtn;
@property (nonatomic,retain) UIButton * downBtn;
@end

@implementation ReaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createUI];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self createUI];
//    }
//    return self;
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    [self createUI];
//}

- (void)createUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"readbg"];
    //imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];

    self.textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH-64-40)];
    self.textview.editable = NO;
    
    self.textview.backgroundColor = [UIColor lightTextColor];
    self.textview.font = [UIFont systemFontOfSize:20];
    self.textview.pagingEnabled = YES;
    self.textview.delegate = self;
    
    
    self.upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.upBtn.frame = CGRectMake(20, screenH-40, 100, 40);
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downBtn.frame = CGRectMake(screenW-120, screenH-40, 100, 40);
    
    [self.upBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [self.downBtn setTitle:@"下一页" forState:UIControlStateNormal];
    
    self.numpages = [[UILabel alloc] initWithFrame:CGRectMake(0, screenH-40, screenW, 40)];
    self.numpages.textAlignment = NSTextAlignmentCenter;
    self.numpages.backgroundColor = [UIColor colorWithRed:0.12 green:0.1 blue:0.07 alpha:0.7];
    self.numpages.textColor = [UIColor whiteColor];
    
    [_upBtn addTarget:self action:@selector(upPage) forControlEvents:UIControlEventTouchUpInside];
    [_downBtn addTarget:self action:@selector(downPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.textview];
    [self.view addSubview:self.numpages];
    [self.view addSubview:_upBtn];
    [self.view addSubview:_downBtn];
    
    
}

- (void)upPage
{
    if(self.textview.contentOffset.y - (screenH-104) >= 0){
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        
        self.textview.contentOffset = CGPointMake(0, self.textview.contentOffset.y - (screenH-104));
        
        [UIView commitAnimations];
    }
}

- (void)downPage
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    
    self.textview.contentOffset = CGPointMake(0, self.textview.contentOffset.y + (screenH-104));
    
    [UIView commitAnimations];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentPage = self.textview.contentOffset.y/(screenH-1044);
    self.numpages.text = [NSString stringWithFormat:@"%.0f/%.0f", self.currentPage, self.totalPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
