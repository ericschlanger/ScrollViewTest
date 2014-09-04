//
//  ViewController.h
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/2/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardLocation.h"

@class CardView;
@protocol CardViewDelegate

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset;

@end

@interface CardView : UIView

- (void)setLocation:(CardLocation *)cardLocation;

@property (nonatomic, weak) id<CardViewDelegate> delegate;

@end
