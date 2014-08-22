//
//  ZoomableImageView.h
//  PopPrototype
//
//  Created by Sam Davies on 22/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import UIKit;

@interface ZoomableImageView : UIImageView

@property (nonatomic, assign) CGRect baseFrame;

- (void)toggleZoom;

@end
