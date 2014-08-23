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

#import "PTCOverlayPresentationController.h"
#import <POP/POP.h>

@interface PTCOverlayPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end


@implementation PTCOverlayPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
  if(self) {
    self.dimmingView = [UIView new];
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  }
  return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
  return CGRectInset(self.containerView.bounds, 20, 20);
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
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    opacityAnimation.toValue = @0.0;
    [opacityAnimation setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
      [self.dimmingView removeFromSuperview];
    }];
    [self.dimmingView pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
  } completion:nil];
}

@end
