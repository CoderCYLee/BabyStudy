//
//  RootViewController.h
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapDetectingDelegate.h"

@class SoundWrapper;
@interface MathViewController : UIViewController <UIScrollViewDelegate>
{
	int m_expectedCount;
	int m_currentCount;

	NSMutableArray *m_melonImageViews;
    NSMutableArray *m_defaultMelonFrames;
    
	IBOutlet UIImageView *m_bascketView;
	IBOutlet UIImageView *m_bascket_glow;
	IBOutlet UIImageView *m_expectedCountView;
	IBOutlet UIImageView *m_currentCountView;
	IBOutlet UIImageView *m_elephentImageView;
    
	UIImageView *m_pickImageView;
	CGPoint m_fruitPosition;
	
	IBOutlet UIView *m_clearView;
	IBOutlet UIView *m_failView;
	
	SoundWrapper *m_pickSound;
	SoundWrapper *m_putSound;
	SoundWrapper *m_buttonSound;
	
	NSMutableArray *m_expectedCountSounds;
	NSMutableArray *m_currentCountSounds;

	NSMutableArray *m_praiseSounds;
	NSMutableArray *m_blameSounds;
	
    UIScrollView *m_parentScrollView;
}

@property (nonatomic, retain)  UIScrollView *m_parentScrollView;

@property (nonatomic, assign) id <TapDetectingDelegate> m_tapDetectingDelegate;

- (void) setUpSounds;
- (void) addCurrentCount;
- (IBAction) replay;
- (IBAction) donePressed;

@end
