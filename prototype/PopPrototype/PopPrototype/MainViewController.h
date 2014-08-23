//
//  MainViewController.h
//  PopPrototype
//
//  Created by Sam Davies on 16/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import UIKit;
#import "ProgressIndicator.h"

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet ProgressIndicator *progressIndicator;

- (IBAction)handleRandomisePressed:(id)sender;

@end
