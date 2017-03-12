//
//  PopoverView.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSpace 10

@class PopoverView;

@protocol PopoverViewDelegate <NSObject>

- (void)popoverView:(PopoverView *)popoverView selectedAtIndex:(int)index;

@end

@interface PopoverView : UIImageView

@property(nonatomic, assign) id<PopoverViewDelegate> delegate;
@property(nonatomic, retain) NSMutableArray *buttons;

- (void)addMenuItem:(NSString *)name;

@end
