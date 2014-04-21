//
//  DSLTransition.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLTransition.h"

@implementation DSLTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the view to transfer
    UIView *viewToTransferFrom = [(id<DSLTransitionDataSource>)fromViewController viewToTransfer];
    UIView *snapshot = [viewToTransferFrom snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [transitionContext.containerView
                      convertRect:viewToTransferFrom.frame
                      fromView:viewToTransferFrom.superview];
    
    // Get the view we're animating to
    UIView *viewToTransferTo = [(id<DSLTransitionDataSource>)toViewController viewToTransfer];
    
    // Hide the actual views being transferred to/from
    viewToTransferFrom.hidden = YES;
    viewToTransferTo.hidden = YES;
    
    // Is this a push or pop animation?
    NSArray *navVCs = fromViewController.navigationController.viewControllers;
    NSUInteger indexOfFrom = [navVCs indexOfObject:fromViewController];
    NSUInteger indexOfTo = [navVCs indexOfObject:toViewController];
    BOOL pushing = indexOfFrom < indexOfTo;
    
    // Before animation: set the "to" vc's alpha to 0 if pushing, 1 if popping
    toViewController.view.alpha = !pushing;
    
    // Establish view hierarchy
    if (pushing) {
        [transitionContext.containerView addSubview:toViewController.view];
    }
    else {
        [transitionContext.containerView insertSubview:toViewController.view
                                          belowSubview:fromViewController.view];
    }
    [transitionContext.containerView addSubview:snapshot];
    
    [UIView animateWithDuration:duration animations:^{
        if (pushing) {
            // Fade in the "to" view controller if pushing
            toViewController.view.alpha = 1.0f;
        }
        else {
            // Fade out the "from" view controller if popping
            fromViewController.view.alpha = 0.0f;
        }
        
        // Move the image view
        snapshot.frame = [transitionContext.containerView
                          convertRect:viewToTransferTo.frame
                          fromView:viewToTransferTo.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [snapshot removeFromSuperview];
        viewToTransferFrom.hidden = NO;
        viewToTransferTo.hidden = NO;

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
