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

#import "PTCWelcomeViewController.h"
#import <POP/POP.h>
#import <Tweaks/FBTweakInline.h>
#import "PTCOverlayTransitioningDelegate.h"

@interface PTCWelcomeViewController ()

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> overlayTransitioningDelegate;

@end

@implementation PTCWelcomeViewController
            
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self animateView:self.doNotPressLabel toHidden:YES];
  self.doNotPressLabel.hidden = NO;
  self.overlayTransitioningDelegate = [PTCOverlayTransitioningDelegate new];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"dangerOverlay"]) {
    UIViewController *destinationVC = segue.destinationViewController;
    destinationVC.transitioningDelegate = self.overlayTransitioningDelegate;
    destinationVC.modalPresentationStyle = UIModalPresentationCustom;
  }
}

- (IBAction)handleDoNotPressPressed:(id)sender {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self shakeView:self.doNotPressButton];
    [self animateView:self.doNotPressLabel toHidden:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self animateView:self.doNotPressLabel toHidden:YES];
    });
  });
}

#pragma mark - Utility methods
- (void)shakeView:(UIView *)view {
  view.userInteractionEnabled = NO;
  
  POPSpringAnimation *shakeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
  shakeAnimation.velocity = @(FBTweakValue(@"Do Not Press", @"Button Shake", @"Velocity", 2000, 0, 3000));
  shakeAnimation.springBounciness = FBTweakValue(@"Do Not Press", @"Button Shake", @"Bounciness", 20, 0, 40);
  [shakeAnimation setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
    view.userInteractionEnabled = YES;
  }];
  
  [view.layer pop_addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

- (void)animateView:(UIView *)view toHidden:(BOOL)hide {
  CGFloat opacity = hide ? 0.0 : 1.0;
  CGFloat scale   = hide ? FBTweakValue(@"Do Not Press", @"Label", @"Hidden Scale", 0.3, 0.0, 3.0) : 1.0;
  CGFloat yOffset = hide ? FBTweakValue(@"Do Not Press", @"Label", @"Hidden yOffset", -50.0, -100.0, 100.0) : 0.0;
  
  POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  opacityAnimation.toValue = @(opacity);
  [self.doNotPressLabel.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
  
  CGFloat springBounciness = FBTweakValue(@"Do Not Press", @"Label", @"Bounciness", 4.0, 0, 50.0);
  CGFloat springVelocity = FBTweakValue(@"Do Not Press", @"Label", @"Velocity", 20.0, 0, 100.0);
  
  POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(scale, scale)];
  scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(springVelocity, springVelocity)];
  scaleAnimation.springBounciness = springBounciness;
  [self.doNotPressLabel.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
  
  POPSpringAnimation *yOffsetAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
  yOffsetAnimation.toValue = @(yOffset);
  yOffsetAnimation.velocity = @(springVelocity);
  yOffsetAnimation.springBounciness = springBounciness;
  [self.doNotPressLabel.layer pop_addAnimation:yOffsetAnimation forKey:@"yOffsetAnimation"];
}

@end
