//
//  BlockButton.m
//  PopPrototype
//
//  Created by Sam Davies on 15/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "BlockButton.h"

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
}

@end
