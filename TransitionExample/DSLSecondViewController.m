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

@property (nonatomic, weak) IBOutlet UILabel *overviewLabel;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end


@implementation DSLSecondViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.thing.title;
    self.overviewLabel.text = self.thing.overview;
    self.imageView.image = self.thing.image;

    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
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

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:[DSLTransitionFromSecondToFirst class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}


#pragma mark UIGestureRecognizer handlers

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }

        self.interactivePopTransition = nil;
    }

}

@end
