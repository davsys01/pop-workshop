//
//  BlockButton.m
//  PopPrototype
//
//  Created by Sam Davies on 15/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "BlockButton.h"
#import <POP/POP.h>

IB_DESIGNABLE
@implementation BlockButton

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    [self configureButton];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    [self configureButton];
  }
  return self;
}

- (CGSize)intrinsicContentSize {
  CGSize size = [super intrinsicContentSize];
  size.width += 50;
  size.height += 20;
  return size;
}

- (void)configureButton {
  self.layer.cornerRadius = 5.0;
  
  // Add some touch handlers
  [self addTarget:self action:@selector(zoomIn) forControlEvents:UIControlEventTouchDown];
  [self addTarget:self action:@selector(zoomDefault) forControlEvents:UIControlEventTouchUpInside];
}


- (void)zoomIn {
  POPBasicAnimation *zoomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  zoomAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.9, 0.9)];
  [self.layer pop_addAnimation:zoomAnimation forKey:@"layerZoomInAnimation"];
}

- (void)zoomDefault {
  POPSpringAnimation *zoomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  zoomAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
  zoomAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.0, 3.0)];
  zoomAnimation.springBounciness = 25.0;
  [self.layer pop_addAnimation:zoomAnimation forKey:@"layerZoomDefaultAnimation"];
}

@end
