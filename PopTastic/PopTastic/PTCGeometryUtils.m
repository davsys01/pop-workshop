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

#import "PTCGeometryUtils.h"

@implementation PTCGeometryUtils

+ (CGRect)interpolateBetweenRect:(CGRect)r1 andRect:(CGRect)r2 withProportion:(CGFloat)prop {
  return CGRectMake(r1.origin.x    + (r2.origin.x    - r1.origin.x)    * prop,
                    r1.origin.y    + (r2.origin.y    - r1.origin.y)    * prop,
                    r1.size.width  + (r2.size.width  - r1.size.width)  * prop,
                    r1.size.height + (r2.size.height - r1.size.height) * prop);
}

@end
