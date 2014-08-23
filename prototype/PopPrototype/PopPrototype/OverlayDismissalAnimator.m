//
//  OverlayDismissalAnimator.m
//  PopPrototype
//
//  Created by Sam Davies on 18/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "OverlayDismissalAnimator.h"
#import <POP/POP.h>

@implementation OverlayDismissalAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  toView.userInteractionEnabled = YES;
  toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
  
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  toView.layer.cornerRadius = 4.0;
  
  [[transitionContext containerView] addSubview:toView];
  
  POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
  positionAnimation.toValue = @(fromView.layer.bounds.size.height / 2.0 + [transitionContext containerView].bounds.size.height);

  [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    [transitionContext completeTransition:YES];
  }];
  
  [fromView.layer pop_addAnimation:positionAnimation forKey:@"yPositionAnimation"];
}

@end
