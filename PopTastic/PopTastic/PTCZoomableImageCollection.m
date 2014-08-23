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

#import "PTCZoomableImageCollection.h"

@interface PTCZoomableImageCollection ()

@property (nonatomic, strong) NSArray *imageViews;

@end

@implementation PTCZoomableImageCollection

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    [self createDefaults];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    [self createDefaults];
  }
  return self;
}

#pragma mark - Property overrides
- (void)setImages:(NSArray *)images {
  if(images != _images) {
    _images = images;
    [self updateLayout];
  }
}

- (void)setImageHeight:(CGFloat)imageHeight {
  if(imageHeight != _imageHeight) {
    _imageHeight = imageHeight;
    [self updateLayout];
  }
}

#pragma mark - Lifecycle
- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateLayout];
}

- (void)prepareForInterfaceBuilder {
  self.backgroundColor = [UIColor clearColor];
  UILabel *placeholderView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - self.imageHeight, self.bounds.size.width, self.imageHeight)];
  placeholderView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
  placeholderView.text = @"ZoomableImageColletion Placeholder";
  placeholderView.textColor = [UIColor whiteColor];
  placeholderView.textAlignment = NSTextAlignmentCenter;
  [self addSubview:placeholderView];
}

#pragma mark - Utility Methods
- (void)updateLayout {
  if(self.images && self.images.count > 0) {
    if(!self.imageViews) {
      [self createImageViews];
    }
    
    CGFloat width = self.bounds.size.width / self.images.count;
    CGFloat yValue = self.bounds.size.height - self.imageHeight;
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *iv, NSUInteger idx, BOOL *stop) {
      iv.frame = CGRectMake(idx * width, yValue, width, self.imageHeight);
    }];
  }
}

- (void)createImageViews {
  NSMutableArray *ivs = [NSMutableArray array];
  CGFloat width = self.bounds.size.width / self.images.count;
  CGFloat yValue = self.bounds.size.height - self.imageHeight;
  for (int i=0; i < self.images.count; i++) {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, yValue, width, self.imageHeight)];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.image = self.images[i];
    iv.clipsToBounds = YES;
    [self addSubview:iv];
    [ivs addObject:iv];
  }
  
  self.imageViews = [ivs copy];
}

- (void)createDefaults {
  self.backgroundColor = [UIColor clearColor];
  // Create some defaults
  self.imageHeight = 200;
  if([UIImage imageNamed:@"green"]) {
    NSArray *images = @[[UIImage imageNamed:@"green"],
                        [UIImage imageNamed:@"yellow"],
                        [UIImage imageNamed:@"soft"],
                        [UIImage imageNamed:@"droplet"]];
    self.images = images;
  }
}

@end
