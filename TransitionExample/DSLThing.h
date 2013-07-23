//
//  DSLThing.h
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//


@interface DSLThing : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy, readonly) NSString *overview;

+ (NSArray*)exampleThings;

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image overview:(NSString*)overview;

@end
