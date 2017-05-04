//
//  ShareViewController.m
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ShareViewController.h"
//#import "UMSocial.h"

@interface ShareViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITextView *myTextView;
    UIImageView *imageView;
}

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.title = @"分享";
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mh"]];
       
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 100, 40)];
    label.text = @"宝宝寄语:";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font= [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:14];
    label.textColor = [UIColor orangeColor];
    [self.view addSubview:label];
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 69, screenW-120, screenH/3-10)];
    imv.image = [UIImage imageNamed:@"wenbenkuang02"];
    [self.view addSubview:imv];
    
    myTextView = [[UITextView alloc]initWithFrame:CGRectMake(100, 69, screenW-120, screenH/3-10)];
    myTextView.text = @"祝宝宝健康快乐成长!";
    myTextView.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:14];
    myTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //myTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wenbenkuang02.png"]];
    [self.view addSubview:myTextView];
    
    UILabel * picLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, screenH/2, 100, 40)];
    picLabel.text = @"宝宝照片";
    picLabel.backgroundColor = [UIColor clearColor];
    picLabel.textAlignment = NSTextAlignmentCenter;
    picLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:14];
    picLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:picLabel];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, screenH/2, screenW-120, screenH/3-10)];
    imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"xk"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * clickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGesture:)];
    [imageView addGestureRecognizer:clickGesture];
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(screenW/3*2, screenH/6*5, screenW/3-20, 46);
//    [button setBackgroundImage:[UIImage imageNamed:@"weibobg.png"] forState:UIControlStateNormal];
//    [button setAlpha:0.7];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    UIBarButtonItem *login = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = login;
}

- (void)login
{
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"55229ae0fd98c571f90014b2" shareText:myTextView.text                                     shareImage:imageView.image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechatSession,UMShareToTencent,UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ,UMShareToDouban, UMShareToEmail, UMShareToSms, nil] delegate:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myTextView resignFirstResponder];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickGesture:(UIGestureRecognizer*)gesture {
    UIActionSheet * as = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"本地相册", nil];
    [as showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController * pc = [[UIImagePickerController alloc] init];
    
    if(buttonIndex == 0 && TARGET_IPHONE_SIMULATOR) {
        return;
    }
    
    if(buttonIndex == 0) {
        pc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if(buttonIndex == 1) {
        pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pc.delegate = self;
    [self presentViewController:pc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
