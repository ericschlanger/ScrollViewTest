//
//  CardLocation.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardLocation.h"

 const CGFloat center0 = 245;
 const CGFloat alpha0 = .3f;
 const CGFloat transform0 = 29/32.0;

 const CGFloat center1 = 270;
 const CGFloat alpha1 = .5f;
 const CGFloat transform1 = 31/32.f;

 const CGFloat center2 = 289;
 const CGFloat alpha2 = 1.f;
 const CGFloat transform2 = 1;

 const CGFloat center3 = 777.25;
 const CGFloat alpha3 = 1.f;
 const CGFloat transform3 = 1;

 const CGFloat center4 = 762.25;
 const CGFloat alpha4 = .5f;
 const CGFloat transform4 = 31/32.f;

 const CGFloat center5 = 740.25;
 const CGFloat alpha5 = .3f;
 const CGFloat transform5 = 29/32.0;


@implementation CardLocation

+ (instancetype)locationWithCenter:(CGPoint)center alpha:(CGFloat)alpha transform:(CGAffineTransform)transform index:(NSInteger)index {
    CardLocation *location = [[CardLocation alloc]init];
    location.center = center;
    location.alpha = alpha;
    location.transform = transform;
    location.locationIndex = index;
    return location;
}

+ (instancetype)locationForIndex:(NSInteger)index {

    switch (index) {
        case 0:
            return [CardLocation locationWithCenter:CGPointMake(160, center0) alpha:alpha0 transform:CGAffineTransformMakeScale(transform0, transform0) index:0];
        case 1:
            return [CardLocation locationWithCenter:CGPointMake(160, center1) alpha:alpha1 transform:CGAffineTransformMakeScale(transform1, transform1) index:1];
        case 2:
            return [CardLocation locationWithCenter:CGPointMake(160, center2) alpha:alpha2 transform:CGAffineTransformMakeScale(transform2, transform2) index:2];
        case 3:
            return [CardLocation locationWithCenter:CGPointMake(160, center3) alpha:alpha3 transform:CGAffineTransformMakeScale(transform3, transform3) index:3];
        case 4:
            return [CardLocation locationWithCenter:CGPointMake(160, center4) alpha:alpha4 transform:CGAffineTransformMakeScale(transform4, transform4) index:4];
        case 5:
            return [CardLocation locationWithCenter:CGPointMake(160, center5) alpha:alpha5 transform:CGAffineTransformMakeScale(transform5, transform5) index:5];
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
    location.locationIndex = start.locationIndex;
    return location;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Center Y: %f Alpha: %f Affine: %f",self.center.y,self.alpha,self.transform.a];
}

@end
