//
//  GuoDongBlockView.m
//  BabyStudy
//
//  Created by 李春阳 on 15/4/5.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GuoDongBlockView.h"

@interface GuoDongBlockView()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) CGFloat from;
@property (nonatomic) CGFloat to;
@property (nonatomic) BOOL animating;
@end

@implementation GuoDongBlockView

- (void)startAnimationFrom:(CGFloat)from to:(CGFloat)to
{
    
    self.from = from;
    self.to = to;
    self.animating = YES;
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)completeAnimation
{
    self.animating = NO;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)tick:(CADisplayLink *)displayLink
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CALayer *layer = self.layer.presentationLayer;
    
    CGFloat progress = 1;
    if (!self.animating) {
        progress = 1;
    } else {
        progress = 1 - (layer.position.y - self.to/ (self.from - self.to));
        
    }
    
    CGFloat height = CGRectGetHeight(rect);
    
    CGFloat deltaHeight = height / 2*(0.5 - fabs(progress-0.5));
                                     
    CGPoint topLeft = CGPointMake(0, deltaHeight);
    CGPoint topRight = CGPointMake(CGRectGetWidth(rect), deltaHeight);
    CGPoint bottomLeft = CGPointMake(0, height);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(rect), height);
    
    // 贝赛尔曲线相关
    UIBezierPath* path = [UIBezierPath bezierPath];
    [[UIColor blueColor] setFill];
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:CGPointMake(CGRectGetMidX(rect), 0)];
    [path addLineToPoint:bottomRight];
    [path addQuadCurveToPoint:bottomLeft controlPoint:CGPointMake(CGRectGetMidX(rect), height - deltaHeight)];
    [path closePath];
    [path fill];
}


@end
