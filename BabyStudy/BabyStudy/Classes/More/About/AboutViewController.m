//
//  AboutViewController.m
//  BabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *vesionLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 要用桥接
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    self.vesionLabel.text = [NSString stringWithFormat:@"版本%.1f",currentVersion.doubleValue];
    
    /**
    + (NSString *)appVersion{
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
     }
     */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
