//
//  OverlayPresentationController.m
//  PopPrototype
//
//  Created by Sam Davies on 18/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "OverlayPresentationController.h"
#import <POP/POP.h>

@interface OverlayPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation OverlayPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
  self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
  if(self) {
    self.dimmingView = [UIView new];
    self.dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
  }
  return self;
}


- (void)presentationTransitionWillBegin {
  self.dimmingView.frame = self.containerView.bounds;
  self.dimmingView.alpha = 0.0;
  [self.containerView insertSubview:self.dimmingView atIndex:0];
  
  [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    opacityAnimation.toValue = @1.0;
    [self.dimmingView pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
  } completion:nil];
}

- (void)dismissalTransitionWillBegin {
  [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    POPBasicAnimation *opactiyAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    opactiyAnimation.toValue = @0.0;
    [self.dimmingView pop_addAnimation:opactiyAnimation forKey:@"opacityAnimation"];
  } completion:nil];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
  return CGSizeMake(floorf(parentSize.width * 2/3.0), floorf(parentSize.height * 2/3.0));
}

- (CGRect)frameOfPresentedViewInContainerView {
  CGRect presentedViewFrame = CGRectZero;
  presentedViewFrame.size = [self sizeForChildContentContainer:(UIView<UIContentContainer> *)self.presentedView withParentContainerSize:self.containerView.bounds.size];
  presentedViewFrame.origin.x = (self.containerView.bounds.size.width - presentedViewFrame.size.width) / 2.0;
  presentedViewFrame.origin.y = (self.containerView.bounds.size.height - presentedViewFrame.size.height) / 2.0;
  return presentedViewFrame;
}

- (void)containerViewWillLayoutSubviews {
  self.dimmingView.frame = self.containerView.bounds;
  self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}


@end
