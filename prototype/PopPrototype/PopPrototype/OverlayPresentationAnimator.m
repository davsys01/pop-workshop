//
//  OverlayPresentationAnimator.m
//  PopPrototype
//
//  Created by Sam Davies on 18/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "OverlayPresentationAnimator.h"
#import <POP/POP.h>
#import <Tweaks/FBTweakInline.h>

@implementation OverlayPresentationAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  fromView.userInteractionEnabled = NO;
  fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
  
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
