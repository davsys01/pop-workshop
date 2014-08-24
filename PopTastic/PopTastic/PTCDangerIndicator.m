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

#import "PTCDangerIndicator.h"
#import <pop/POP.h>
#import <Tweaks/FBTweakInline.h>

@interface PTCDangerIndicator ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *innerCircle;

@end

@implementation PTCDangerIndicator

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    [self createLayers];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    [self createLayers];
  }
  return self;
}

- (void)layoutSubviews {
  CGFloat shortestSide = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) - self.trackWidth / 2.0;
  self.trackLayer.bounds = CGRectMake(0, 0, shortestSide, shortestSide);
  self.innerCircle.bounds = CGRectMake(0, 0, shortestSide, shortestSide);
  self.trackLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) / 2.0);
  self.innerCircle.position = self.trackLayer.position;
  
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.innerCircle.bounds];
  self.innerCircle.path = circlePath.CGPath;
  
  UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.trackLayer.bounds.size.width / 2.0,
                                                                              self.trackLayer.bounds.size.height / 2.0)
                                                           radius:(self.trackLayer.bounds.size.width - self.trackLayer.lineWidth) / 2.0
                                                       startAngle:-M_PI_2
                                                         endAngle:3 * M_PI_2
                                                        clockwise:YES];
  self.trackLayer.path = trackPath.CGPath;
}

#pragma mark - Property Overrides
- (void)setValue:(CGFloat)value {
  if(value != _value) {
    _value = MIN(MAX(0.0, value), 1.0);
    POPSpringAnimation *trackAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    trackAnimation.toValue = @(_value);
    trackAnimation.velocity = @(FBTweakValue(@"Danger Indicator", @"Value Animation", @"Velocity", 10.0, 0.0, 20.0));
    trackAnimation.springBounciness = FBTweakValue(@"Danger Indicator", @"Value Animation", @"Bounciness", 10.0, 0.0, 20.0);
    [self.trackLayer pop_addAnimation:trackAnimation forKey:@"strokeEnd"];
  }
}

- (void)setTrackWidth:(CGFloat)trackWidth {
  if(trackWidth != _trackWidth) {
    _trackWidth = trackWidth;
    self.trackLayer.lineWidth = _trackWidth;
    [self setNeedsLayout];
  }
}

#pragma mark - Utility methods
- (void)createLayers {
  self.backgroundColor = [UIColor clearColor];
  _trackWidth = 15.0;
  
  self.innerCircle = [CAShapeLayer layer];
  self.innerCircle.lineWidth = 0.0;
  self.innerCircle.fillColor = [UIColor redColor].CGColor;
  
  self.trackLayer = [CAShapeLayer layer];
  self.trackLayer.lineWidth = self.trackWidth;
  self.trackLayer.lineCap = @"butt";
  self.trackLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.6].CGColor;
  self.trackLayer.fillColor = [UIColor clearColor].CGColor;
  
  [self.layer addSublayer:self.innerCircle];
  [self.layer addSublayer:self.trackLayer];
}


@end
