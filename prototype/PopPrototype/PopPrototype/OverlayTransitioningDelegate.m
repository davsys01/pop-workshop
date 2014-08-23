//
//  OverlayTransitioningDelegate.m
//  PopPrototype
//
//  Created by Sam Davies on 17/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "OverlayTransitioningDelegate.h"
#import "OverlayPresentationController.h"
#import "OverlayPresentationAnimator.h"
#import "OverlayDismissalAnimator.h"

@implementation OverlayTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
  return [[OverlayPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  return [OverlayPresentationAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return [OverlayDismissalAnimator new];
}

@end
