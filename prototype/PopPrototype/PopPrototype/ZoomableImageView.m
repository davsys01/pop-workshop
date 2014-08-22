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
  [self.superview bringSubviewToFront:self];
  CGRect newFrame = self.zoomed ? self.baseFrame : self.superview.bounds;
  POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
  frameAnimation.toValue = [NSValue valueWithCGRect:newFrame];
  frameAnimation.springBounciness = 10.0;
  self.zoomed = !self.zoomed;
  [self pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}


@end
