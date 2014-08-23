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
  [self toggleZoomWithVerticalVelocity:CGPointZero];
}

- (void)toggleZoomWithVerticalVelocity:(CGPoint)velocity {
  [self.superview bringSubviewToFront:self];
  CGRect newFrame = self.zoomed ? self.baseFrame : self.superview.bounds;
  POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
  frameAnimation.toValue = [NSValue valueWithCGRect:newFrame];
  frameAnimation.springBounciness = 6.0;
  frameAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(velocity.x, velocity.y, velocity.x, velocity.y)];
  self.zoomed = !self.zoomed;
  [self pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)dragImage:(UIPanGestureRecognizer *)gesture {
  [self.superview bringSubviewToFront:self];
  if (gesture.state == UIGestureRecognizerStateChanged) {
    CGPoint offset = [gesture translationInView:self];
    CGFloat proportionComplete = MIN(1.0, ABS(offset.y / self.superview.bounds.size.height * 2.0));
    CGRect diff = CGRectMake(proportionComplete * (self.baseFrame.origin.x - self.superview.bounds.origin.x),
                             proportionComplete * (self.baseFrame.origin.y - self.superview.bounds.origin.y),
                             proportionComplete * (self.baseFrame.size.width - self.superview.bounds.size.width),
                             proportionComplete * (self.baseFrame.size.height - self.superview.bounds.size.height));
    CGRect intermediateFrame;
    if (self.zoomed) {
      intermediateFrame = CGRectMake(self.superview.bounds.origin.x + diff.origin.x,
                                     self.superview.bounds.origin.y + diff.origin.y,
                                     self.superview.bounds.size.width + diff.size.width,
                                     self.superview.bounds.size.height + diff.size.height);
    } else {
      intermediateFrame = CGRectMake(self.baseFrame.origin.x - diff.origin.x,
                                     self.baseFrame.origin.y - diff.origin.y,
                                     self.baseFrame.size.width - diff.size.width,
                                     self.baseFrame.size.height - diff.size.height);
    }
    self.frame = intermediateFrame;
    
  } else if (gesture.state == UIGestureRecognizerStateEnded) {
    [self toggleZoomWithVerticalVelocity:[gesture velocityInView:self]];
  }
}


@end
