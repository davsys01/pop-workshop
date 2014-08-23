//
//  UIColor+ColorMap.m
//  PopPrototype
//
//  Created by Sam Davies on 23/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "UIColor+ColorMap.h"

@implementation UIColor (ColorMap)

+ (instancetype)colorForNormalisedValue:(CGFloat)value {
  
  CGFloat (^interpolate)(CGFloat, CGPoint, CGPoint) = ^CGFloat(CGFloat v, CGPoint p0, CGPoint p1) {
    return (v-p0.x) * (p1.y - p0.y) / (p1.x - p0.x) + p0.y;
  };
  
  CGFloat (^mapper)(CGFloat) = ^CGFloat(CGFloat v) {
    if( v <= -0.75 ) {
      return 0;
    } else if ( v <= -0.25 ) {
      return interpolate( v, CGPointMake(-0.75, 0.0), CGPointMake(-0.25, 1.0));
    } else if ( v <= 0.25 ) {
      return 1.0;
    } else if ( v <= 0.75 ) {
      return interpolate( v, CGPointMake(0.25, 1.0), CGPointMake(0.75, 0.0));
    } else {
      return 0.0;
    }
  };
  
  // Remap the value to [-1, 1]
  CGFloat remap = value * 2.0 - 1.0;
  
  return [UIColor colorWithRed:mapper(remap - 0.5) green:mapper(remap) blue:mapper(remap + 0.5) alpha:1.0];
}

@end
