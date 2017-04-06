//
//  VideoViewController.m
//  BabyStudy
//
//  Created by Cyrill on 2017/3/30.
//  Copyright © 2017年 cyrill. All rights reserved.
//

#import "VideoViewController.h"
#import "LocationViewController.h"

@interface VideoViewController ()

@property (nonatomic, strong) LocationViewController *localVC;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视频";
    
    self.localVC.hidesBottomBarWhenPushed  = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [self.navigationController pushViewController:self.localVC animated:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LocationViewController *)localVC
{
    if (!_localVC) {
        _localVC = [[LocationViewController alloc] init];
    }
    return _localVC;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
