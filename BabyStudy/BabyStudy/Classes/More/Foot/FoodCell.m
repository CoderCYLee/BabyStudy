//
//  FoodCell.m
//  BabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FoodCell.h"

@interface FoodCell()

@end

@implementation FoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, (screenH-64)/3)];
    imageView.image = [UIImage imageNamed:@"BookShelfCell.png"];
    [self addSubview:imageView];
    
    CGFloat margin = 20;
    CGFloat cellH = (screenH-64-40)/3;
    CGFloat foodW = (screenW-margin*3)/3;
    
    _food1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _food1.contentMode = UIViewContentModeScaleAspectFill;
    _food1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _food1.frame = CGRectMake(10, 20, foodW, cellH-30);
    _food1.tag = 1;
    
    _food2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _food2.contentMode = UIViewContentModeScaleAspectFill;
    _food2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _food2.frame = CGRectMake(10 +foodW + margin , 20, foodW, cellH-30);
    _food2.tag = 2;
    
    _food3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _food3.contentMode = UIViewContentModeScaleAspectFill;
    _food3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _food3.frame = CGRectMake(10+2*(foodW+margin), 20, foodW, cellH-30);
    _food3.tag = 3;
    
    [self addSubview:_food1];
    [self addSubview:_food2];
    [self addSubview:_food3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
