//
//  ViewController.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/2/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardView.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"1");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    ScrollDirection scrollDirection;
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionDown;
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionUp;
    }
    NSLog(@"CO: %f",scrollView.contentOffset.y);
    NSLog(@"H: %f",self.table.contentSize.height);
    if(scrollDirection == ScrollDirectionDown && scrollView.contentOffset.y <= 0) {
        self.table.alwaysBounceVertical = NO;
        [self.delegate cardView:self moveWithOffset:-1];
    } else if(scrollDirection == ScrollDirectionUp && scrollView.contentOffset.y >= 400) { // FIGURE OUT THIS NUMBER
        self.table.alwaysBounceVertical = NO;
        [self.delegate cardView:self moveWithOffset:1];
    } else {
        self.table.alwaysBounceVertical = YES;
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)setLocation:(CardLocation *)cardLocation {
    self.center = cardLocation.center;
    self.alpha = cardLocation.alpha;
    self.layer.affineTransform = cardLocation.transform;
}

@end
