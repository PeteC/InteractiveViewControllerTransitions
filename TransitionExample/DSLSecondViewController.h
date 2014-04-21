//
//  DSLSecondViewController.h
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLTransition.h"

@class DSLThing;


@interface DSLSecondViewController : UIViewController <DSLTransitionDataSource>

@property (nonatomic, strong) DSLThing *thing;

@end
