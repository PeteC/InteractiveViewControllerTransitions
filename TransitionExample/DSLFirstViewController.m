//
//  DSLFirstViewController.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLFirstViewController.h"

#import "DSLThing.h"
#import "DSLThingCell.h"
#import "DSLSecondViewController.h"
#import "DSLTransitionFromFirstToSecond.h"

@interface DSLFirstViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *things;

@end


@implementation DSLFirstViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _things = [DSLThing exampleThings];
        self.title = @"Things";
    }

    return self;
}


#pragma mark UIViewController methods

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DSLSecondViewController class]]) {
        // Get the selected item index path
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];

        // Set the thing on the view controller we're about to show
        if (selectedIndexPath != nil) {
            DSLSecondViewController *secondViewController = segue.destinationViewController;
            secondViewController.thing = self.things[selectedIndexPath.row];
        }
    }
}


#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[DSLSecondViewController class]]) {
        return [[DSLTransitionFromFirstToSecond alloc] init];
    }
    else {
        return nil;
    }
}


#pragma mark UICollectionViewControllerDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.things.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSLThingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DSLThingCell class]) forIndexPath:indexPath];

    DSLThing *thing = self.things[indexPath.row];
    cell.titleLabel.text = thing.title;
    cell.imageView.image = thing.image;

    return cell;
}


#pragma mark

- (DSLThingCell*)collectionViewCellForThing:(DSLThing*)thing {
    NSUInteger thingIndex = [self.things indexOfObject:thing];
    if (thingIndex == NSNotFound) {
        return nil;
    }

    return (DSLThingCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:thingIndex inSection:0]];
}

@end
