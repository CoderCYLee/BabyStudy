//
//  ThinkViewController.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThinkViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate>
@property(nonatomic,retain)UITextView * textview;
@property(nonatomic,retain)UILabel * numpages;
@property float currentPage;
@property float totalPage;
@property (nonatomic,retain)UIButton * button1;
@property (nonatomic,retain)UIButton * button2;

@end
