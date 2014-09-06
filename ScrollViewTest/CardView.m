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

@property (nonatomic, strong) UITableView *table;
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
        self.table.backgroundColor = [UIColor orangeColor];
        [self addSubview:_table];

        
        self.lastContentOffset = 0;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor magentaColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if([self isAtTop] || [self isAtBottom]) {
        [self.delegate endedDraggingWithCardView:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.table scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:NO];
    
    if(scrollView.isDragging) {
        if([self isAtBottom]) {
            [self.delegate cardView:self moveWithOffset:-scrollView.contentOffset.y + kBottomThreshold withDirection:ScrollDirectionUp];
        } else if ([self isAtTop]) {
            [self.delegate cardView:self moveWithOffset:-scrollView.contentOffset.y withDirection:ScrollDirectionUp];
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

@end
