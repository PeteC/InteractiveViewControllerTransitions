//
//  DSLTransition.h
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

@protocol DSLTransitionDataSource <NSObject>

- (UIView *)viewToTransfer;

@end

@interface DSLTransition : NSObject<UIViewControllerAnimatedTransitioning>

@end
