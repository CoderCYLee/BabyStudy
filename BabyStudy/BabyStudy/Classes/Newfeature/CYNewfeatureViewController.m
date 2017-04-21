//
//  CYNewfeatureViewController.m
//  CYNewsByXL
//
//  Created by cyrill on 15/3/16.
//  Copyright (c) 2015年 CY. All rights reserved.
//

#define CYNewfeatureImageCount 4

#import "CYNewfeatureViewController.h"
#import "CYTabBarController.h"

@interface CYNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation CYNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    //[self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i<CYNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"introduce_0%d-568h", i + 1];
        
        imageView.image = [UIImage imageNamed:name];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        if (i == CYNewfeatureImageCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(CYNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = CYColor(246, 246, 246);
}

/**
 *  处理最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView可以跟用户进行交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
    // 2.添加分享按钮
    //[self setupShareButton:imageView];
}

/**
 *  添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.adjustsImageWhenHighlighted = NO;
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 设置titleLabel四周的内边距
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 设置imageView四周的内边距
    // top left bottom right
    // 内边距 == 自切
    // 被切掉的区域就不能显示内容了
    // contentEdgeInsets : 切掉按钮内部的内容
    // imageEdgeInsets : 切掉按钮内部UIImageView的内容
    // titleEdgeInsets : 切掉按钮内部UILabel的内容
    
    // 3.设置frame
    shareButton.width = 200;
    shareButton.height = 35;
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
}

/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    // 4.设置文字
    [startButton setTitle:@"进入新闻" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareButtonClick:(UIButton *)shareButton
{
    // 选中状态取反
    shareButton.selected = !shareButton.isSelected;
}

- (void)start
{
    CYTabBarController *tab = [[CYTabBarController alloc] init];
    [self presentViewController:tab animated:YES completion:nil];
}

/**
 1.push
 * 无法销毁之前的控制器
 * 可以显示新的控制器
 
 2.modal
 * 无法销毁之前的控制器
 * 可以显示新的控制器
 
 3.切换window的rootViewController
 * 可以销毁之前的控制器
 * 可以显示新的控制器
 */


@end
