//
//  CYTabBarController.m
//  CYNewsByXL
//
//  Created by cyrill on 15/3/16.
//  Copyright (c) 2015年 CY. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYTabBar.h"
#import "MoreViewController.h"
#import "MusicListViewController.h"
#import "StoryViewController.h"
#import "ShareViewController.h"
#import "VideoViewController.h"
#import "GameBaseViewController.h"

@interface CYTabBarController ()

@end

@implementation CYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
}

+ (void)initialize
{
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    CYTabBar *customTabBar = [[CYTabBar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    StoryViewController *story = [[StoryViewController alloc] init];
    [self addOneChlildVc:story title:@"故事" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_news_hl"];
    
    MusicListViewController *music = [[MusicListViewController alloc] init];
    [self addOneChlildVc:music title:@"音乐" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_picture_hl"];
    
//    VideoViewController *video = [[VideoViewController alloc] init];
//    [self addOneChlildVc:video title:@"视频" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_picture_hl"];
    
    GameBaseViewController *game = [[GameBaseViewController alloc] init];
    [self addOneChlildVc:game title:@"游戏" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_video_hl"];
    
    ShareViewController *share = [[ShareViewController alloc] init];
    [self addOneChlildVc:share title:@"分享" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_setting_hl"];
    
    MoreViewController *more = [[MoreViewController alloc] init];
    [self addOneChlildVc:more title:@"更多" imageName:@"activity_dragonball_spot2" selectedImageName:@"tabbar_setting_hl"];
    
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];

    // 声明这张图片不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
