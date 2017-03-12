//
//  RootViewController.m
//  LittleBabyStudy
//
//  Created by 李春阳 on 15/4/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MathViewController.h"
#import "SoundWrapper.h"
#import <QuartzCore/QuartzCore.h>

@interface MathViewController ()
- (void) handleDoubleTap:(CGPoint) tapLocation;
@end

@implementation MathViewController
@synthesize m_parentScrollView, m_tapDetectingDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden=YES;
    self.title=@"摘西瓜";
    self.view.frame = CGRectMake(0, 0, screenW, screenH);
    m_clearView.frame = CGRectMake(0, 0, screenW, screenH);
    m_failView.frame = CGRectMake(0, 0, screenW, screenH);;
    [self setUpSounds];
    
    m_melonImageViews = [[NSMutableArray alloc] initWithCapacity:10];
    m_defaultMelonFrames = [[NSMutableArray alloc] initWithCapacity: 10];
    for(UIImageView *u in [self.view subviews])
    {
        if (1000 < u.tag )
        {
            [m_melonImageViews addObject:u];
            [m_defaultMelonFrames addObject: [NSValue valueWithCGRect: u.frame]];
        }
    }
    UIImage *elephent1 = [UIImage imageNamed:@"elephent1.png"];
    UIImage *elephent2 = [UIImage imageNamed:@"elephent2.png"];
    NSArray *elephentArray = [[NSArray alloc] initWithObjects: elephent1, elephent2, nil];
    m_elephentImageView.animationImages = elephentArray;
    m_elephentImageView.animationDuration = 1.0;
    [m_elephentImageView startAnimating];
    [self reset];
}

- (void) setUpSounds
{    
	NSBundle *mainBundle = [NSBundle mainBundle];
	m_pickSound = [[SoundWrapper alloc] initWithContentsOfFile:[mainBundle pathForResource:@"pick" ofType:@"wav"]];
	m_putSound = [[SoundWrapper alloc] initWithContentsOfFile:[mainBundle pathForResource:@"put" ofType:@"wav"]];
	m_buttonSound = [[SoundWrapper alloc] initWithContentsOfFile:[mainBundle pathForResource:@"button" ofType:@"wav"]];
	m_expectedCountSounds = [[NSMutableArray alloc] initWithCapacity:10];
	for (int i=1; i<=10; i++) 
    {
		NSString *melonName = [NSString stringWithFormat:@"%imelon", i];
		SoundWrapper *voice = [[SoundWrapper alloc] initWithContentsOfFile:[mainBundle pathForResource:melonName ofType:@"wav"]];
		[m_expectedCountSounds addObject: voice];

	}
	m_currentCountSounds = [[NSMutableArray alloc] initWithCapacity: 10];
	for (int i=1; i<=10; i++) {
		NSString *melonName = [NSString stringWithFormat:@"%i-m",i];
		SoundWrapper *voice  = [[SoundWrapper alloc] initWithContentsOfFile:[mainBundle pathForResource:melonName ofType:@"wav"]];
		[m_currentCountSounds addObject:voice];

	}
	m_blameSounds = [[NSMutableArray alloc]initWithCapacity:3];
	[m_blameSounds addObject:[[SoundWrapper alloc]initWithContentsOfFile:[mainBundle pathForResource:@"no" ofType:@"wav"]]];
	[m_blameSounds addObject:[[SoundWrapper alloc]initWithContentsOfFile:[mainBundle pathForResource:@"oh no" ofType:@"wav"]]];
	[m_blameSounds addObject:[[SoundWrapper alloc]initWithContentsOfFile:[mainBundle pathForResource:@"Oops" ofType:@"wav"]]];
	m_praiseSounds = [[NSMutableArray alloc] initWithCapacity:2];
	[m_praiseSounds addObject:[[SoundWrapper alloc]initWithContentsOfFile:[mainBundle pathForResource:@"good work" ofType:@"wav"]]];
	[m_praiseSounds addObject:[[SoundWrapper alloc]initWithContentsOfFile:[mainBundle pathForResource:@"great" ofType:@"wav"]]];
}

-(void)reset
{
    int i = 0;
    for (UIImageView *imageView in m_melonImageViews) 
    {
        imageView.frame = [[m_defaultMelonFrames objectAtIndex: i] CGRectValue];
        imageView.hidden = NO;
        
        i++;
    }
    srand((unsigned)time(NULL) << 2);
	m_expectedCount = arc4random() % 10 + 1;
	m_expectedCountView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%ia.png",m_expectedCount]];
    SoundWrapper *voice = [m_expectedCountSounds objectAtIndex: m_expectedCount - 1];
	[voice play];
    m_currentCount = 0;
    m_currentCountView.image = nil;
	m_bascketView.image = [UIImage imageNamed: @"bascket_w.png"];
    [m_clearView removeFromSuperview];
    [m_failView removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	for(UIImageView *melon in m_melonImageViews)
    {
		if ([touch view] == melon && m_pickImageView == nil) 
        {
			m_pickImageView = melon;
			m_fruitPosition = melon.center;
			[m_pickSound play];
            m_parentScrollView.scrollEnabled = NO;
			break;
		}
	}
        UITouch *onetouch=[touches anyObject];
        if(onetouch.tapCount==1)
        {
            self.navigationController.navigationBarHidden=YES;
        }
        else if(onetouch.tapCount==2)
        {
            self.navigationController.navigationBarHidden=NO;
        }
}

- (void)touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog(@"faf");
	UITouch *touch = [touches anyObject];
    
    if (m_pickImageView != nil) 
    {
        // 拿到m_pickImageView在其父view中的touch点rect
        m_pickImageView.center = [touch locationInView: [m_pickImageView superview]];
        
        if (CGRectContainsRect(m_bascketView.frame, m_pickImageView.frame ) 
            || CGRectContainsPoint(m_bascketView.frame, m_pickImageView.center)) 
        {
            m_bascket_glow.hidden = NO;
        }
        else
        {
            m_bascket_glow.hidden = YES;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    m_parentScrollView.scrollEnabled = YES;
    m_parentScrollView.delaysContentTouches = NO;
    UITouch *touch = [touches anyObject];
    if([touch tapCount] == 2) 
    {
        CGPoint tapLocation = [touch locationInView: self.view];
        
        [self handleDoubleTap: tapLocation];
    }

	if (m_pickImageView != nil) 
    {
        // 拖拽的西瓜碰到篮子了(判断给定的点是否被一个CGRect包含)
		if (CGRectContainsPoint(m_bascketView.frame, m_pickImageView.center)) 
        {
            [m_putSound play];
            [self addCurrentCount];
            m_pickImageView.hidden = YES;
            m_bascket_glow.hidden = YES;
		}
        else // 如果没有碰到，返回
        {
			m_pickImageView.center = m_fruitPosition;
		}
        m_pickImageView = nil;
	}	
}

- (void) addCurrentCount
{
	m_currentCount++;
	m_currentCountView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%ia.png",m_currentCount]];
	m_bascketView.image = [UIImage imageNamed: [NSString stringWithFormat:@"bascket_w%i.png",m_currentCount]];
	SoundWrapper *voice = [m_currentCountSounds objectAtIndex: m_currentCount - 1];
	[voice play];
}

- (IBAction) donePressed
{
	[m_buttonSound play];
	if (m_currentCount == m_expectedCount) 
    {
		int i = arc4random() % 2;
		SoundWrapper *voice = [m_praiseSounds objectAtIndex:i];
		[voice play];
		[self.view addSubview: m_clearView];
		m_clearView.alpha = 0;
		m_clearView.alpha = 1;
	}
    else 
    {
		int i = arc4random()%3;
		SoundWrapper *voice = [m_blameSounds objectAtIndex:i];
		[voice play];
		[self.view addSubview: m_failView];
        m_failView.alpha = 0;
		m_failView.alpha = 1;
	}
	
}

- (IBAction)replay
{
	[m_buttonSound play];
    [self reset];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.75];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache: YES];
    [UIView commitAnimations];
}

- (void) handleDoubleTap: (CGPoint) tapLocation
{
    if ([m_tapDetectingDelegate respondsToSelector: @selector(tapDetectView:gotDoubleTapAtPoint:)])
        [m_tapDetectingDelegate tapDetectView:self.view gotDoubleTapAtPoint: tapLocation];
}

@end
