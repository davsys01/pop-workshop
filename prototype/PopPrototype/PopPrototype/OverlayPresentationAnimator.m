//
//  OverlayPresentationAnimator.m
//  PopPrototype
//
//  Created by Sam Davies on 18/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "OverlayPresentationAnimator.h"
#import <POP/POP.h>

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
  
  [[transitionContext containerView] addSubview:toView];
  
  
  POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
  positionAnimation.toValue = @(toView.layer.position.y);
  positionAnimation.fromValue = @(-toView.layer.bounds.size.height / 2.0);
  positionAnimation.velocity = @(10);
  positionAnimation.springBounciness = 15.0;
  [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    [transitionContext completeTransition:YES];
  }];
  
  [toView.layer pop_addAnimation:positionAnimation forKey:@"yPositionAnimation"];
}

@end
