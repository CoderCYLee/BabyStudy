//
//  AppDelegate.m
//  BabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "CYTabBarController.h"
#import "NewfeatureViewController.h"
#import "PanoramaViewController.h"
#import "UMSocial.h"

@interface AppDelegate ()

@property (nonatomic, strong) NewfeatureViewController *introductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createShortcutItems];
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 2.设置窗口的根控制器
    // 要用桥接
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;

    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    // 获取对象，创建对象用来取值
    // NSUserDefaults 不用关心文件位置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 取值
    NSString *lastVersion = [defaults objectForKey:versionKey];

    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) { // 当前版本号 == 上次使用的版本：显示HMTabBarViewController
        CYTabBarController *tabBarVC = [[CYTabBarController alloc] init];
        
        NSArray *tip = @[@"在音乐和游戏里,空白地方点两下会弹出带有返回的导航栏哦~", @"在分享界面里,点击分享,您可以将宝宝的照片和祝福语上传到网络哦~", @"在更多里面,有宝宝饮食及宝宝健康,请及时注意宝宝的身体哦~", @"点击故事播放界面里面的菜单按钮可以切换自己喜欢的背景图哦~"];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:self.window.bounds];
        img2.image = [UIImage imageNamed:@"yd5"];
        img2.contentMode = UIViewContentModeScaleAspectFill;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenW/6, screenH*0.7, screenW/3*2, screenW/3)];
        label.text = tip[arc4random()%4];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.7;
        label.font = [UIFont systemFontOfSize:20];
        [img2 addSubview:label];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(screenW/3, label.y-35, screenW/3, 30)];
        title.backgroundColor = [UIColor blackColor];
        title.alpha = 0.7;
        title.text = @"小提示";
        title.textColor = [UIColor orangeColor];
        title.textAlignment = NSTextAlignmentCenter;
        [img2 addSubview:title];
        [tabBarVC.view addSubview:img2];
        
        [UIView animateWithDuration:1.0f delay:2.0f options:UIViewAnimationOptionTransitionNone animations:^{
            img2.alpha = 0;
            
            
        } completion:^(BOOL finished) {
            [img2 removeFromSuperview];
        }];
        
        self.window.rootViewController = tabBarVC;
        //
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        [self.window setRootViewController:[[PanoramaViewController alloc] init]];
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        // 同步
        [defaults synchronize];
    }
    // 3.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:@"55229ae0fd98c571f90014b2"];
    
    return YES;
}

// 淡入淡出更换 rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow * window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

/**
 *  在viewWillAppear里面添加如下代码：
 //分组列表头部空白处理
 CGRect frame = myTableView.tableHeaderView.frame;
 frame.size.height = 0.1;
 UIView *headerView = [[UIView alloc] initWithFrame:frame];
 [myTableView setTableHeaderView:headerView];
 */


//// 价格符号和价格删除线
//- (void)drawRect:(CGRect)rect{
//    if (_ifDelete) {
//        UIFont *font = [UIFont systemFontOfSize:self.font.pointSize];
//        CGSize size = CGSizeMake(320,2000);
//        CGRect labelRect = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
//        CGContextRef c = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(c, MXCOLOR_GRAY.CGColor);
//        CGContextSetLineWidth(c, 1);
//        CGContextBeginPath(c);
//        CGFloat halfWayUp = rect.size.height/2 + rect.origin.y;
//        CGContextMoveToPoint(c, rect.origin.x, halfWayUp );//开始点
//        CGContextAddLineToPoint(c, rect.origin.x + labelRect.size.width, halfWayUp);//结束点
//        CGContextStrokePath(c);
//    }
//    if (_ifRMB){
//        UIFont *font = [UIFont systemFontOfSize:self.font.pointSize];
//        UIFont *fuhaofont = [UIFont systemFontOfSize:12];
//        UIColor *color = MXCOLOR_ORANGE;
//        CGSize size = CGSizeMake(320,2000);
//        CGRect labelRect = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
//        NSString *fuhao = @"￥";
//        CGContextRef c = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(c, MXCOLOR_ORANGE.CGColor);
//        [fuhao drawAtPoint:CGPointMake(rect.size.width - labelRect.size.width - 12, 4) withAttributes:@{NSFontAttributeName:fuhaofont,NSForegroundColorAttributeName:color}];
//        CGContextStrokePath(c);
//    }
//    [super drawRect:rect];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)createShortcutItems {
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 9.0) {
        
//        UIApplicationShortcutIcon *shortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_1"];
//        
//        UIMutableApplicationShortcutItem *firstItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"first" localizedTitle:@"制作照片书" localizedSubtitle:nil icon:shortcutIcon userInfo:nil];
//        //        UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"打开" localizedTitle:@"打开"];
//        UIApplicationShortcutIcon *shortcutIcon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_2"];
//        UIMutableApplicationShortcutItem *shortItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"alert" localizedTitle:@"制作相框" localizedSubtitle:nil icon:shortcutIcon1 userInfo:nil];
//        NSArray *shortItems = [[NSArray alloc] initWithObjects:firstItem, shortItem2, firstItem, shortItem2, nil];
//        [[UIApplication sharedApplication] setShortcutItems:shortItems];
    
    }
}

@end
