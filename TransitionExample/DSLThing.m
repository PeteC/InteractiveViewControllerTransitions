//
//  DSLThing.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLThing.h"


@implementation DSLThing

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image {
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _image = image;
    }

    return self;
}

@end
