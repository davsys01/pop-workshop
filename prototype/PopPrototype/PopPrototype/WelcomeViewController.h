//
//  ViewController.h
//  PopPrototype
//
//  Created by Sam Davies on 15/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import UIKit;
#import "BlockButton.h"

@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet BlockButton *doNotPressButton;
@property (weak, nonatomic) IBOutlet UILabel *doNotPressLabel;

- (IBAction)handleDismiss:(id)sender;
- (IBAction)handleDoNotPress:(id)sender;


@end

