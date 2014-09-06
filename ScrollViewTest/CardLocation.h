//
//  CardLocation.h
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat const center1;
extern CGFloat const alpha1;
extern CGFloat const transform1;

extern CGFloat const center2;
extern CGFloat const alpha2;
extern CGFloat const transform2;

extern CGFloat const center3;
extern CGFloat const alpha3;
extern CGFloat const transform3;

@interface CardLocation : NSObject

@property (nonatomic) CGPoint center;
@property (nonatomic) CGAffineTransform transform;
@property (nonatomic) CGFloat alpha;

+ (instancetype)locationWithCenter:(CGPoint)center alpha:(CGFloat)alpha transform:(CGAffineTransform)transform;
+ (instancetype)locationForIndex:(int)index;
+ (instancetype)locationForStart:(NSInteger)startIdx end:(NSInteger)endIdx distancePercentage:(CGFloat)distancePercent;


@end
