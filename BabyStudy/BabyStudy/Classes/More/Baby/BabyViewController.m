//
//  BabyViewController.m
//  BabyStudy
//
//  Created by 李春阳 on 15/4/2.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "BabyViewController.h"

@interface BabyViewController ()

@end

@implementation BabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baby.163.com"]]];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
