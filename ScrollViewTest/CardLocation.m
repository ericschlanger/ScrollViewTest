//
//  CardLocation.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardLocation.h"

static const CGFloat center1 = 245;
static const CGFloat alpha1 = .3f;
static const CGFloat transform1 = 29/32.0;

static const CGFloat center2 = 270;
static const CGFloat alpha2 = .5f;
static const CGFloat transform2 = 31/32.f;

static const CGFloat center3 = 289;
static const CGFloat alpha3 = 1.f;
static const CGFloat transform3 = 1;

static const CGFloat center4 = 500;
static const CGFloat alpha4 = 1.f;
static const CGFloat transform4 = 1;

static const CGFloat center5 = 490;
static const CGFloat alpha5 = .5f;
static const CGFloat transform5 = 31/32.f;

static const CGFloat center6 = 480;
static const CGFloat alpha6 = .3f;
static const CGFloat transform6 = 29/32.0;


@implementation CardLocation

+ (instancetype)locationWithCenter:(CGPoint)center alpha:(CGFloat)alpha transform:(CGAffineTransform)transform {
    CardLocation *location = [[CardLocation alloc]init];
    location.center = center;
    location.alpha = alpha;
    location.transform = transform;
    return location;
}

+ (instancetype)locationForIndex:(int)index {

    switch (index) {
        case 0:
            return [CardLocation locationWithCenter:CGPointMake(160, center1) alpha:alpha1 transform:CGAffineTransformMakeScale(transform1, transform1)];
        case 1:
            return [CardLocation locationWithCenter:CGPointMake(160, center2) alpha:alpha2 transform:CGAffineTransformMakeScale(transform2, transform2)];
        case 2:
            return [CardLocation locationWithCenter:CGPointMake(160, center3) alpha:alpha3 transform:CGAffineTransformMakeScale(transform3, transform3)];
        case 3:
            return [CardLocation locationWithCenter:CGPointMake(160, center4) alpha:alpha4 transform:CGAffineTransformMakeScale(transform4, transform4)];
        case 4:
            return [CardLocation locationWithCenter:CGPointMake(160, center5) alpha:alpha5 transform:CGAffineTransformMakeScale(transform5, transform5)];
        case 5:
            return [CardLocation locationWithCenter:CGPointMake(160, center6) alpha:alpha6 transform:CGAffineTransformMakeScale(transform6, transform6)];
    }
    return nil;
}

+ (instancetype)locationForStart:(NSInteger)startIdx end:(NSInteger)endIdx distancePercentage:(CGFloat)distancePercent {
    
    CardLocation *start = [CardLocation locationForIndex:startIdx];
    CardLocation *end = [CardLocation locationForIndex:endIdx];
    CardLocation *location = [[CardLocation alloc]init];
    location.center = CGPointMake(160, start.center.y + (end.center.y - start.center.y)*distancePercent);
    location.alpha = start.alpha + (end.alpha - start.alpha)*distancePercent;
    CGFloat newTrans = start.transform.a + (end.transform.a - start.transform.a)*distancePercent;
    location.transform = CGAffineTransformMakeScale(newTrans, newTrans);
    return location;
}

//- (instancetype)locationForCurrent:(



@end
