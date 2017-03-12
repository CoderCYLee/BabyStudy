//
//  MusicListViewController.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Music, MusicBoxViewController;

@interface MusicListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    MusicBoxViewController *musicBoxViewController;
    Music *music;
    NSMutableArray *MusicBox;
    UITableViewCell *tableViewCell;
    UITableView *mytableview;
}
@property (nonatomic, strong) MusicBoxViewController *musicBoxViewController;
@property (nonatomic, strong) Music *music;
@property (nonatomic, copy) NSMutableArray *MusicBox;


@end
