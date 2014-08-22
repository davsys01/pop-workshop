//
//  ZoomableImageCollection.m
//  PopPrototype
//
//  Created by Sam Davies on 22/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "ZoomableImageCollection.h"
#import "ZoomableImageView.h"

@interface ZoomableImageCollection ()

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, strong) NSArray *imageViews;

@end

@implementation ZoomableImageCollection

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images imageHeight:(CGFloat)imageHeight {
  self = [super initWithFrame:frame];
  if(self) {
    self.images = images;
    self.imageHeight = imageHeight;
    [self updateLayout];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateLayout];
}

#pragma mark - Utility Methods
- (void)updateLayout {
  if(!self.imageViews) {
    [self createImageViews];
  }
  
  CGFloat width = self.bounds.size.width / self.images.count;
  CGFloat yValue = self.bounds.size.height - self.imageHeight;
  [self.imageViews enumerateObjectsUsingBlock:^(ZoomableImageView *iv, NSUInteger idx, BOOL *stop) {
    iv.baseFrame = CGRectMake(idx * width, yValue, width, self.imageHeight);
  }];
}

- (void)createImageViews {
  NSMutableArray *ivs = [NSMutableArray array];
  CGFloat width = self.bounds.size.width / self.images.count;
  CGFloat yValue = self.bounds.size.height - self.imageHeight;
  for (int i=0; i < self.images.count; i++) {
    ZoomableImageView *iv = [[ZoomableImageView alloc] initWithFrame:CGRectMake(i * width, yValue, width, self.imageHeight)];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.image = self.images[i];
    iv.clipsToBounds = YES;
    [self addSubview:iv];
    [ivs addObject:iv];
  }
  
  self.imageViews = [ivs copy];
}

@end
