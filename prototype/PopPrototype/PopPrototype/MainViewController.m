//
//  MainViewController.m
//  PopPrototype
//
//  Created by Sam Davies on 16/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "MainViewController.h"
#import "OverlayTransitioningDelegate.h"
#import "PhotoCell.h"

@interface MainViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.imageNames = @[@"green", @"yellow", @"soft", @"droplet"];
  self.transitioningDelegate = [OverlayTransitioningDelegate new];
  self.photoCollectionView.dataSource = self;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"displayWelcome"]) {
    UIViewController *destinationVC = segue.destinationViewController;
    destinationVC.modalPresentationStyle = UIModalPresentationCustom;
    destinationVC.transitioningDelegate = self.transitioningDelegate;
  }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PhotoCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
  cell.photoImageView.image = [UIImage imageNamed:self.imageNames[indexPath.item]];
  return cell;
}

@end
