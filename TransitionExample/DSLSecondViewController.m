//
//  DSLSecondViewController.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLSecondViewController.h"

#import "DSLThing.h"


@interface DSLSecondViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end


@implementation DSLSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.thing.title;
    self.imageView.image = self.thing.image;
}

@end
