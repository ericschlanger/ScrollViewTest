//
//  ViewController.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/2/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardView.h"

static const CGFloat kBottomThreshold = 438.5;

@interface CardView () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation CardView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.table.showsVerticalScrollIndicator = NO;
        self.table.backgroundColor = [UIColor clearColor];
        [self addSubview:_table];

        self.lastContentOffset = 0;
    }
    return self;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if([self isAtTop]) {
        [self.delegate endedDraggingWithCardView:self withDirection:ScrollDirectionDown];
    } else if([self isAtBottom]) {
        [self.delegate endedDraggingWithCardView:self withDirection:ScrollDirectionUp];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    ScrollDirection scrollDirection = ScrollDirectionNone;
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionUp;
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionDown;
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;

    if(scrollView.isDragging) {
        if([self isAtBottom]) {
            [self.delegate cardView:self moveWithOffset:-scrollView.contentOffset.y + kBottomThreshold withDirection:ScrollDirectionUp];
        } else if ([self isAtTop]) {
            [self.delegate cardView:self moveWithOffset:-scrollView.contentOffset.y withDirection:ScrollDirectionDown];
        }
    }
}

- (BOOL)isAtBottom {
    return self.table.contentOffset.y >= kBottomThreshold;
}

- (BOOL)isAtTop {
    return self.table.contentOffset.y <= 0;
}

- (void)setLocation:(CardLocation *)cardLocation {
    self.center = cardLocation.center;
    self.alpha = cardLocation.alpha;
    self.layer.affineTransform = cardLocation.transform;
    self.lastLocation = cardLocation.locationIndex;
}

- (void)scrollCardToTop {
    [self.table setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - TableView Delgate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate cardView:self didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate cardView:self numberOfRowsinSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate cardView:self cellForIndexAtPath:indexPath];
}

@end
