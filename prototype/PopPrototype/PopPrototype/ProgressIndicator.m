//
//  ProgressIndicator.m
//  PopPrototype
//
//  Created by Sam Davies on 23/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "ProgressIndicator.h"
#import <POP/POP.h>
#import <Tweaks/FBTweakInline.h>
#import "UIColor+ColorMap.h"

@interface ProgressIndicator ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *innerCircle;

@end

@implementation ProgressIndicator

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

- (void)createLayers {
  self.backgroundColor = [UIColor clearColor];
  self.trackLayer = [CAShapeLayer layer];
  self.innerCircle = [CAShapeLayer layer];
  [self.layer addSublayer:self.innerCircle];
  [self.layer addSublayer:self.trackLayer];
  self.innerCircle.lineWidth = 0.0;
  self.innerCircle.fillColor = [UIColor colorForNormalisedValue:self.value].CGColor;
  self.trackLayer.lineWidth = 15.0;
  self.trackLayer.lineCap = @"round";
  self.trackLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.6].CGColor;
  self.trackLayer.fillColor = [UIColor clearColor].CGColor;
}

- (void)layoutSubviews {
  CGFloat shortestSide = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  self.trackLayer.bounds = CGRectMake(0, 0, shortestSide, shortestSide);
  self.innerCircle.bounds = CGRectMake(0, 0, shortestSide, shortestSide);
  self.trackLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) / 2.0);
  self.innerCircle.position = self.trackLayer.position;
  
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.innerCircle.bounds];
  self.innerCircle.path = circlePath.CGPath;
  
  UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:self.trackLayer.position
                                                           radius:(self.trackLayer.bounds.size.width - self.trackLayer.lineWidth) / 2.0
                                                       startAngle:-M_PI_2
                                                         endAngle:3 * M_PI_2
                                                        clockwise:YES];
  self.trackLayer.path = trackPath.CGPath;
}

- (void)setValue:(CGFloat)value {
  if(value != _value) {
    _value = MIN(MAX(0.0, value), 1.0);
    POPSpringAnimation *trackAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    trackAnimation.toValue = @(_value);
    trackAnimation.velocity = @(FBTweakValue(@"ProgressIndicator", @"Value Animation", @"Velocity", 10.0, 0.0, 20.0));
    trackAnimation.springBounciness = FBTweakValue(@"ProgressIndicator", @"Value Animation", @"Bounciness", 10.0, 0.0, 20.0);
    [self.trackLayer pop_addAnimation:trackAnimation forKey:@"strokeEnd"];
    
    self.innerCircle.fillColor = [UIColor colorForNormalisedValue:_value].CGColor;
  }
}

@end
