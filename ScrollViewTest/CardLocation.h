//
//  CardLocation.h
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardLocation : NSObject

@property (nonatomic) CGPoint center;
@property (nonatomic) CGAffineTransform transform;
@property (nonatomic) CGFloat alpha;

+ (CardLocation *)locationForIndex:(int)index;



@end
