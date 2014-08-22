//
//  MainViewController.m
//  PopPrototype
//
//  Created by Sam Davies on 16/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "MainViewController.h"
#import "OverlayTransitioningDelegate.h"
#import "ZoomableImageCollection.h"

@interface MainViewController ()

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@property (nonatomic, strong) ZoomableImageCollection *zoomableImageCollection;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.transitioningDelegate = [OverlayTransitioningDelegate new];
  NSArray *imageNames = @[@"green", @"yellow", @"soft", @"droplet"];
  NSMutableArray *images = [NSMutableArray new];
  [imageNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
    [images addObject:[UIImage imageNamed:name]];
  }];
  self.zoomableImageCollection = [[ZoomableImageCollection alloc] initWithFrame:self.view.bounds
                                                                         images:[images copy]
                                                                    imageHeight:200];
  [self.view insertSubview:self.zoomableImageCollection atIndex:0];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"displayWelcome"]) {
    UIViewController *destinationVC = segue.destinationViewController;
    destinationVC.modalPresentationStyle = UIModalPresentationCustom;
    destinationVC.transitioningDelegate = self.transitioningDelegate;
  }
}

@end
