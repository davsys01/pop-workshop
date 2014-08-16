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

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self hideLabel:YES animated:NO];
}

- (IBAction)handleDismiss:(id)sender {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  });
}

- (IBAction)handleDoNotPress:(id)sender {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self shakeButton:self.doNotPressButton];
    [self hideLabel:NO animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self hideLabel:YES animated:YES];
    });
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

- (void)hideLabel:(BOOL)hide animated:(BOOL)animated {
  CGFloat opacity = hide ? 0.0 : 1.0;
  CGFloat scale   = hide ? FBTweakValue(@"Welcome", @"DNP Label", @"Hidden Scale", 0.3, 0.0, 3.0) : 1.0;
  CGFloat yOffset = hide ? FBTweakValue(@"Welcome", @"DNP Label", @"Hidden yOffset", -50.0, -100.0, 100.0) : 0.0;
  
  POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  opacityAnimation.toValue = @(opacity);
  [self.doNotPressLabel.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
  
  CGFloat springBounciness = FBTweakValue(@"Welcome", @"DNP Label", @"Bounciness", 4.0, 0, 50.0);
  CGFloat springVelocity = FBTweakValue(@"Welcome", @"DNP Label", @"Velocity", 20.0, 0, 100.0);
  
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
