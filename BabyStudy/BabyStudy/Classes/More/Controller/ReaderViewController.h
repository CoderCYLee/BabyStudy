//
//  ReaderViewController.h
//  BabyStudy
//
//  Created by 李春阳 on 15/4/2.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderViewController : UIViewController
@property float currentPage;
@property float totalPage;
@property (nonatomic,retain) UITextView * textview;
@property (nonatomic,retain) UILabel * numpages;
@end
