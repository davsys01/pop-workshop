//
//  PhotoCell.m
//  PopPrototype
//
//  Created by Sam Davies on 22/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecogniser;

@end

@implementation PhotoCell


- (void)prepareGestureRecogniser {
  if (!self.gestureRecogniser) {
    self.gestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecogniser:)];
    self.gestureRecogniser.minimumNumberOfTouches = 1;
    self.gestureRecogniser.maximumNumberOfTouches = 1;
    [self.photoImageView addGestureRecognizer:self.gestureRecogniser];
    self.userInteractionEnabled = YES;
    self.photoImageView.userInteractionEnabled = YES;
    self.clipsToBounds = NO;
    self.photoImageView.clipsToBounds = NO;
  }
}

- (void)handleGestureRecogniser:(UIPanGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateBegan) {
    self.photoImageView.layer.transform = CATransform3DMakeRotation(0.1, 0, 0, 1);
  }
  if (gesture.state == UIGestureRecognizerStateChanged) {
    NSLog(@"%@", NSStringFromCGPoint([gesture translationInView:self]));
    self.photoImageView.layer.position = [gesture translationInView:self];
  }
  if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
    self.photoImageView.layer.transform = CATransform3DIdentity;
  }
}

@end
