//
//  PopoverView.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PopoverView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.buttons = [NSMutableArray array];
    }
    return self;
}

- (void)addMenuItem:(NSString *)name
{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setTitle:name forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:menuButton];
    
    [self.buttons addObject:menuButton];
}

- (void)buttonClicked:(UIButton *)button
{
    int index = (int)[self.buttons indexOfObject:button];
    
    
    if ([self.delegate respondsToSelector:@selector(popoverView:selectedAtIndex:)])
        [self.delegate performSelector:@selector(popoverView:selectedAtIndex:) withObject:self withObject:@(index)];
}

- (void)layoutSubviews
{
    CGSize size = self.frame.size;
    CGFloat buttonHeight = (size.height-20-([self.buttons count]+1)*kSpace) / [self.buttons count];
    
    for (int i = 0; i < [self.buttons count]; ++i) {
        UIButton *button = [self.buttons objectAtIndex:i];
        button.frame = CGRectMake(kSpace, buttonHeight*i+(i+1)*kSpace+20, size.width-2*kSpace, buttonHeight);
    }
}

@end
