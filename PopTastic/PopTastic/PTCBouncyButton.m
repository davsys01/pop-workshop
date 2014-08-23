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

#import "PTCBouncyButton.h"
#import <POP/POP.h>

@implementation PTCBouncyButton

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
  size.width += 20.0;
  return size;
}

- (void)configureButton {
  [self addTarget:self action:@selector(zoomOnPress) forControlEvents:UIControlEventTouchDown];
  [self addTarget:self action:@selector(restoreZoom) forControlEvents:UIControlEventTouchUpInside];
}

- (void)zoomOnPress {
  POPBasicAnimation *zoomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  zoomAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.1, 1.1)];
  [self.layer pop_addAnimation:zoomAnimation forKey:@"zoomAnimation"];
}

- (void)restoreZoom {
  POPSpringAnimation *zoomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  zoomAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
  zoomAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(-5.0, -5.0)];
  zoomAnimation.springBounciness = 15.0;
  [self.layer pop_addAnimation:zoomAnimation forKey:@"restoreAnimation"];
}

@end
