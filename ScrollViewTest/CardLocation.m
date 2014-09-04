//
//  CardLocation.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardLocation.h"

static const CGFloat center1 = 258;
static const CGFloat alpha1 = .3f;
static const CGFloat transform1 = 29/32.0;

static const CGFloat center2 = 271;
static const CGFloat alpha2 = .5f;
static const CGFloat transform2 = 31/32.f;

static const CGFloat center3 = 284;
static const CGFloat alpha3 = 1.f;
static const CGFloat transform3 = 1;



@implementation CardLocation

+ (CardLocation *)locationForIndex:(int)index {
    switch (index) {
        case 1:
            return [CardLocation locationWithCenter:CGPointMake(160, center1) alpha:alpha1 transform:CGAffineTransformMakeScale(transform1, transform1)];
        case 2:
            return [CardLocation locationWithCenter:CGPointMake(160, center2) alpha:alpha2 transform:CGAffineTransformMakeScale(transform2, transform2)];
        case 3:
            return [CardLocation locationWithCenter:CGPointMake(160, center3) alpha:alpha3 transform:CGAffineTransformMakeScale(transform3, transform3)];
    }
    return nil;
}

+ (instancetype)locationWithCenter:(CGPoint)center alpha:(CGFloat)alpha transform:(CGAffineTransform)transform {
    CardLocation *location = [[CardLocation alloc]init];
    location.center = center;
    location.alpha = alpha;
    location.transform = transform;
    return location;
}



@end
