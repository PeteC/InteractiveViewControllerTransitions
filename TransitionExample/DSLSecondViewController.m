//
//  DSLSecondViewController.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLSecondViewController.h"

#import "DSLFirstViewController.h"
#import "DSLThing.h"
#import "DSLTransitionFromSecondToFirst.h"


@interface DSLSecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end


@implementation DSLSecondViewController


#pragma mark UIViewController methods

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.thing.title;
    self.imageView.image = self.thing.image;
}


#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self && [toVC isKindOfClass:[DSLFirstViewController class]]) {
        return [[DSLTransitionFromSecondToFirst alloc] init];
    }
    else {
        return nil;
    }
}

@end
