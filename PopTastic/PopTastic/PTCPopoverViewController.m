//
//  PTCPopoverViewController.m
//  PopTastic
//
//  Created by Sam Davies on 23/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "PTCPopoverViewController.h"

@interface PTCPopoverViewController ()

@end

@implementation PTCPopoverViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}


- (IBAction)handleDismissButtonPressed:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


@end
