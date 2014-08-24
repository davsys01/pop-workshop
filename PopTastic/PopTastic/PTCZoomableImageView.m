//
// Copyright 2014 Scott Logic
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "PTCZoomableImageView.h"
#import <POP/POP.h>
#import "PTCGeometryUtils.h"

@interface PTCZoomableImageView ()

@property (nonatomic, assign) BOOL zoomed;

@end

@implementation PTCZoomableImageView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    self.baseFrame = frame;
    self.zoomed = NO;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleZoom)];
    [self addGestureRecognizer:tapGesture];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragImage:)];
    [self addGestureRecognizer:panGesture];
  }
  return self;
}

- (void)toggleZoom {
  [self toggleZoomWithVelocity:CGPointZero];
}

- (void)toggleZoomWithVelocity:(CGPoint)velocity {
  [self.superview bringSubviewToFront:self];
  CGRect newFrame = self.zoomed ? self.baseFrame : self.superview.bounds;
  POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
  frameAnimation.toValue = [NSValue valueWithCGRect:newFrame];
  frameAnimation.springBounciness = 6.0;
  frameAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(velocity.x, velocity.y, velocity.x, velocity.y)];
  self.zoomed = !self.zoomed;
  [self pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)setBaseFrame:(CGRect)baseFrame {
  if (!CGRectEqualToRect(_baseFrame, baseFrame)) {
    _baseFrame = baseFrame;
    if(!self.zoomed) {
      self.frame = baseFrame;
    }
  }
}

- (void)dragImage:(UIPanGestureRecognizer *)gesture {
  [self.superview bringSubviewToFront:self];
  if (gesture.state == UIGestureRecognizerStateChanged) {
    CGPoint offset = [gesture translationInView:self];
    CGFloat proportionComplete = MIN(1.0, ABS(offset.y / self.superview.bounds.size.height * 2.0));
    if(self.zoomed) {
      proportionComplete = 1 - proportionComplete;
    }
    self.frame = [PTCGeometryUtils interpolateBetweenRect:self.baseFrame
                                                  andRect:self.superview.bounds
                                           withProportion:proportionComplete];
    
  } else if (gesture.state == UIGestureRecognizerStateEnded) {
    [self toggleZoomWithVelocity:[gesture velocityInView:self]];
  }
}

@end
