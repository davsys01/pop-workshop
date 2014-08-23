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
