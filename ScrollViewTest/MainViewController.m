//
//  MainViewController.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "MainViewController.h"

#import "CardView.h"

#import "CardLocation.h"

static const CGFloat kThreshold = 50;

typedef NS_ENUM(NSUInteger, CardDeckAnimateDirection) {
    CardDeckAnimateDirectionPrev,
    CardDeckAnimateDirectionNext
};

@interface MainViewController () <CardViewDelegate>

@property (nonatomic, strong) UIView *cardContainer;
@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic) NSInteger currentCardIdx;

@property (nonatomic) CGFloat lastYOffset;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    self.cardContainer.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.cardContainer];
    
    [self setupCards];
    self.currentCardIdx = 2;
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)setupCards {
    self.cardArray = [[NSMutableArray alloc]init];
    
    CardView *card1 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card1.delegate = self;
    [self addCard:card1];
    [card1 setLocation:[CardLocation locationForIndex:0]];
    
    CardView *card2 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card2.delegate = self;
    [self addCard:card2];
    [card2 setLocation:[CardLocation locationForIndex:1]];
    
    CardView *card3 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card3.delegate = self;
    [self addCard:card3];
    [card3 setLocation:[CardLocation locationForIndex:2]];
    
    self.lastYOffset = card3.center.y;
}

- (void)moveCardDeck:(CardDeckAnimateDirection)direction {
    if(direction == CardDeckAnimateDirectionPrev) {
       [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
           
            if(self.currentCardIdx - 1 >= 0) {
               [self.cardArray[self.currentCardIdx - 1] setLocation:[CardLocation locationForIndex:0]];
            }
            [self.cardArray[self.currentCardIdx] setLocation:[CardLocation locationForIndex:1]];
           
            if(self.currentCardIdx + 1 < self.cardArray.count) {
                [self.cardArray[self.currentCardIdx + 1] setLocation:[CardLocation locationForIndex:2]];
            }
            if(self.currentCardIdx + 2 < self.cardArray.count) {
                [self.cardArray[self.currentCardIdx + 2] setLocation:[CardLocation locationForIndex:3]];
            }
            if(self.currentCardIdx + 3 < self.cardArray.count) {
                [self.cardArray[self.currentCardIdx + 3] setLocation:[CardLocation locationForIndex:4]];
            }
        } completion:^(BOOL finished) {
            self.currentCardIdx += 1;
        }];
        
    } else if(direction == CardDeckAnimateDirectionNext) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if(self.currentCardIdx - 2 >= 0) {
                [self.cardArray[self.currentCardIdx - 2] setLocation:[CardLocation locationForIndex:1]];
            }
            if(self.currentCardIdx - 1 >= 0) {
                [self.cardArray[self.currentCardIdx - 1] setLocation:[CardLocation locationForIndex:2]];
            }
            [self.cardArray[self.currentCardIdx] setLocation:[CardLocation locationForIndex:3]];
            if(self.currentCardIdx + 1 < self.cardArray.count) {
                [self.cardArray[self.currentCardIdx + 1] setLocation:[CardLocation locationForIndex:4]];
            }
            if(self.currentCardIdx + 2 < self.cardArray.count) {
                [self.cardArray[self.currentCardIdx + 2] setLocation:[CardLocation locationForIndex:5]];
            }
        } completion:^(BOOL finished) {
            self.currentCardIdx -= 1;
        }];
    }
}


- (void)addCard:(CardView *)card {
    [self.cardContainer addSubview:card];
    [self.cardArray addObject:card];
}

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset withDirection:(ScrollDirection)direction {
    cardView.center = CGPointMake(cardView.center.x, offset + self.lastYOffset);
    
    CardView *card = self.cardArray[self.currentCardIdx-1];
    CGFloat ratio = offset/kThreshold;
    if(ratio > 1) {
        ratio = 1;
    }
    
    [card setLocation:[CardLocation locationForStart:1 end:2 distancePercentage:ratio]];
}

- (void)endedDraggingWithCardView:(CardView *)cardView {
    self.lastYOffset = cardView.center.y;
}



@end
