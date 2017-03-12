//
//  Music.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/3/31.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject {
    NSString *musicName;
    NSString *musicType;
}
@property (nonatomic, copy) NSString *musicName;
@property (nonatomic, copy) NSString *musicType;

- (id)initWithMusicName:(NSString*)name andMusicType:(NSString*)type;
@end
