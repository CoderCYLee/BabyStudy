//
//  Music.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Music.h"

@implementation Music
@synthesize musicName;
@synthesize musicType;

- (id)initWithMusicName:(NSString*)name andMusicType:(NSString*)type
{
    self = [super init];
    musicName = [[NSString alloc] initWithString:name];
    musicType = [[NSString alloc] initWithString:type];
    return self;
}

@end
