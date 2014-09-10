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
- (void)cardViewDidMoveHalfWay:(CardView *)cardView aboveHalfwayMark:(BOOL)isAbove;
- (void)endedDraggingWithCardView:(CardView *)cardView withDirection:(ScrollDirection)direction;

- (NSInteger)cardView:(CardView *)cardView numberOfRowsinSection:(NSInteger)section;
- (UITableViewCell *)cardView:(CardView *)cardView cellForIndexAtPath:(NSIndexPath*)indexPath;
- (void)cardView:(CardView *)cardView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CardView : UIView

- (void)setLocation:(CardLocation *)cardLocation;
- (void)scrollCardToTop;

@property (nonatomic) NSInteger lastLocation;
@property (nonatomic, weak) id<CardViewDelegate> delegate;
@property (nonatomic, strong) UITableView *table;

@end
