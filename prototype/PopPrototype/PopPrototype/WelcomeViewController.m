//
//  ViewController.m
//  PopPrototype
//
//  Created by Sam Davies on 15/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "WelcomeViewController.h"
#import <POP/POP.h>
#import <Tweaks/FBTweakInline.h>

@implementation WelcomeViewController

- (IBAction)handleDismiss:(id)sender {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  });
}

- (IBAction)handleDoNotPress:(id)sender {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self shakeButton:self.doNotPressButton];
  });
}


- (void)shakeButton:(BlockButton *)button {
  button.userInteractionEnabled = NO;
  POPSpringAnimation *shakeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
  CGFloat shakeVelocity = FBTweakValue(@"Button", @"Shake", @"Velocity", 2000, 0, 3000);
  CGFloat shakeBounciness = FBTweakValue(@"Button", @"Shake", @"Bounciness", 20 , 0, 40);
  shakeAnimation.velocity = @(shakeVelocity);
  shakeAnimation.springBounciness = shakeBounciness;
  [shakeAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    button.userInteractionEnabled = YES;
  }];
  [button.layer pop_addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}
@end
