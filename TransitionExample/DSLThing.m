//
//  DSLThing.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLThing.h"


@implementation DSLThing

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image overview:(NSString*)overview {
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _image = image;
        _overview = [overview copy];
    }

    return self;
}

+ (NSArray*)exampleThings {
    return @[
             [[DSLThing alloc] initWithTitle:@"Thing 1" image:[UIImage imageNamed:@"thing01.jpg"] overview:@"Drumstick cow beef fatback turkey boudin. Meatball leberkas boudin hamburger pork belly fatback."],
             [[DSLThing alloc] initWithTitle:@"Thing 2" image:[UIImage imageNamed:@"thing02.jpg"] overview:@"Shank pastrami sirloin, sausage prosciutto spare ribs kielbasa tri-tip doner."],
             [[DSLThing alloc] initWithTitle:@"Thing 3" image:[UIImage imageNamed:@"thing03.jpg"] overview:@"Frankfurter cow filet mignon short loin ham hock salami meatloaf biltong andouille bresaola prosciutto."],
             [[DSLThing alloc] initWithTitle:@"Thing 4" image:[UIImage imageNamed:@"thing04.jpg"] overview:@"Pastrami sausage turkey shank shankle corned beef."],
             [[DSLThing alloc] initWithTitle:@"Thing 5" image:[UIImage imageNamed:@"thing05.jpg"] overview:@"Tri-tip short loin pork belly, pastrami biltong ball tip ham hock. Shoulder ribeye turducken shankle."]
             ];
}

@end
