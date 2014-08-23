//
//  PTCPopoverViewController.m
//  PopTastic
//
//  Created by Sam Davies on 23/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "PTCDangerViewController.h"

@interface PTCDangerViewController ()

@end

@implementation PTCDangerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  // Seed the random number generator
  srand48(time(0));
}


- (IBAction)handleDismissButtonPressed:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)handleRandomiseButtonPressed:(id)sender {
  self.dangerIndicator.value = drand48();
}


@end
