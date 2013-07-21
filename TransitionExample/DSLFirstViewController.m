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

@interface DSLFirstViewController ()

@property (nonatomic, strong) NSArray *things;

@end


@implementation DSLFirstViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _things = @[[[DSLThing alloc] initWithTitle:@"Thing 1" image:[UIImage imageNamed:@"thing01.jpg"]],
                    [[DSLThing alloc] initWithTitle:@"Thing 2" image:[UIImage imageNamed:@"thing02.jpg"]],
                    [[DSLThing alloc] initWithTitle:@"Thing 3" image:[UIImage imageNamed:@"thing03.jpg"]],
                    [[DSLThing alloc] initWithTitle:@"Thing 4" image:[UIImage imageNamed:@"thing04.jpg"]],
                    [[DSLThing alloc] initWithTitle:@"Thing 5" image:[UIImage imageNamed:@"thing05.jpg"]]];
    }

    return self;
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

@end
