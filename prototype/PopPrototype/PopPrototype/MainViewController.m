//
//  MainViewController.m
//  PopPrototype
//
//  Created by Sam Davies on 16/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "MainViewController.h"
#import "OverlayTransitioningDelegate.h"

@interface MainViewController ()

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.transitioningDelegate = [OverlayTransitioningDelegate new];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"displayWelcome"]) {
    UIViewController *destinationVC = segue.destinationViewController;
    destinationVC.transitioningDelegate = self.transitioningDelegate;
  }
}

@end
