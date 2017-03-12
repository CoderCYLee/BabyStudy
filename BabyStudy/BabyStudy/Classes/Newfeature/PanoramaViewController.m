//
//  PanoramaViewController.m
//  Panorama
//
//  Created by sameh mabrouk on 4/21/14.
//  Copyright (c) 2014 sam. All rights reserved.
//

#import "PanoramaViewController.h"
#import "PanoramaView.h"
#import "CYTabBarController.h"

@interface PanoramaViewController ()

@end

@implementation PanoramaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PanoramaView *motionView = [[PanoramaView alloc] initWithFrame:self.view.bounds];
    [motionView setImage:[UIImage imageNamed:@"yd1"]];
    [self.view addSubview:motionView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, screenH /4 * 3, screenW, 500)];
    
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    [motionView addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 15, 210, 40)];
    titleLabel.numberOfLines = 0;
    [titleLabel setText:@"人们的很多习惯都是从小养成的,所以宝宝的教育十分重要"];
    
    [titleLabel setShadowOffset:CGSizeMake(0, 1.0f)];
    [titleLabel setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    button.frame = CGRectMake((self.view.frame.size.width - 100) * 0.5, screenH/4*3+65, 100, 30);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [motionView addSubview:button];
    
    // Do any additional setup after loading the view.
}

- (void)btnClick:(UIButton *)button
{
    CYTabBarController *tabBar = [[CYTabBarController alloc] init];
    
    [self presentViewController:tabBar animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
