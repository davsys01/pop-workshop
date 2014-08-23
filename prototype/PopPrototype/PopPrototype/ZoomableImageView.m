//
//  ZoomableImageView.m
//  PopPrototype
//
//  Created by Sam Davies on 22/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "ZoomableImageView.h"
#import <POP/POP.h>

@interface ZoomableImageView ()

@property (nonatomic, assign) BOOL zoomed;

@end

@implementation ZoomableImageView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    self.baseFrame = frame;
    self.zoomed = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleZoom)];
    [self addGestureRecognizer:tapGesture];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragImage:)];
    [self addGestureRecognizer:panGesture];
    self.userInteractionEnabled = YES;
  }
  return self;
}

- (void)setBaseFrame:(CGRect)baseFrame {
  if(!CGRectEqualToRect(_baseFrame, baseFrame)) {
    _baseFrame = baseFrame;
    if(!self.zoomed) {
      self.frame = baseFrame;
    }
  }
}

- (void)toggleZoom {
  [self toggleZoomWithVerticalVelocity:0];
}

- (void)toggleZoomWithVerticalVelocity:(CGFloat)velocity {
  [self.superview bringSubviewToFront:self];
  CGRect newFrame = self.zoomed ? self.baseFrame : self.superview.bounds;
  POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
  frameAnimation.toValue = [NSValue valueWithCGRect:newFrame];
  frameAnimation.springBounciness = 10.0;
  frameAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(0, velocity, 0, velocity)];
  self.zoomed = !self.zoomed;
  [self pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)dragImage:(UIPanGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateChanged) {
    CGPoint offset = [gesture translationInView:self];
  } else if (gesture.state == UIGestureRecognizerStateEnded) {
    [self toggleZoomWithVerticalVelocity:[gesture velocityInView:self].y];
  }
}


@end
