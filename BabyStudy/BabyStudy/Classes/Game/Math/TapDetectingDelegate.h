//
//  DetectTapProtocol.h
//  LittleBabyStudy
//
//  Created by cyrill on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TapDetectingDelegate <NSObject>

@required
- (void)tapDetectView:(UIView *)view gotDoubleTapAtPoint: (CGPoint)tapPoint;

@end
