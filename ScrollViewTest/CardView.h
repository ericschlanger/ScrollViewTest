//
//  ViewController.h
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/2/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardLocation.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@class CardView;
@protocol CardViewDelegate

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset withDirection:(ScrollDirection)direction;
- (void)endedDraggingWithCardView:(CardView *)cardView;

@end

@interface CardView : UIView

- (void)setLocation:(CardLocation *)cardLocation;

@property (nonatomic, weak) id<CardViewDelegate> delegate;

@end
