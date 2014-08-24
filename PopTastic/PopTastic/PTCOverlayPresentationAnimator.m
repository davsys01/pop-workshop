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

#import "PTCOverlayPresentationAnimator.h"
#import <POP/POP.h>
#import <Tweaks/FBTweakInline.h>

@implementation PTCOverlayPresentationAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  toView.layer.cornerRadius = 4.0;
  toView.center = CGPointMake(toView.center.x, -toView.bounds.size.height / 2.0);
  
  [[transitionContext containerView] addSubview:toView];
  
  POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
  positionAnimation.toValue = @([transitionContext containerView].layer.position.y);
  positionAnimation.velocity = @(FBTweakValue(@"Overlay", @"Presentation", @"Velocity", 10, 0, 30));
  positionAnimation.springBounciness = FBTweakValue(@"Overlay", @"Presentation", @"Bounciness", 15.0, 0, 50.0);
  [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    [transitionContext completeTransition:YES];
  }];
  
  POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  scaleAnimation.springBounciness = FBTweakValue(@"Overlay", @"Presentation", @"Bounciness", 15.0);
  scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.4, 0.6)];
  
  [toView.layer pop_addAnimation:positionAnimation forKey:@"yPositionAnimation"];
  [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

@end
