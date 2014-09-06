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
    
    CardView *card0 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card0.delegate = self;
    [card0 setLocation:[CardLocation locationForIndex:0]];
    
    CardView *card1 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card1.delegate = self;
    [card1 setLocation:[CardLocation locationForIndex:1]];
    
    CardView *card2 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card2.delegate = self;
    [card2 setLocation:[CardLocation locationForIndex:2]];
    
    CardView *card3 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card3.delegate = self;
    [card3 setLocation:[CardLocation locationForIndex:3]];
    
    CardView *card4 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card4.delegate = self;
    [card4 setLocation:[CardLocation locationForIndex:4]];
    
    CardView *card5 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card5.delegate = self;
    [card5 setLocation:[CardLocation locationForIndex:5]];
    
    [self addCard:card0];
    [self addCard:card1];
    [self addCard:card2];
    [self addCard:card5];
    [self addCard:card4];
    [self addCard:card3];
    
}

- (void)moveCardDeck:(CardDeckAnimateDirection)direction {
    if(direction == CardDeckAnimateDirectionNext) {
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
            [self currentCardChanged];
        }];
        
    } else if(direction == CardDeckAnimateDirectionPrev) {
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
            [self currentCardChanged];
        }];
    }
}

- (void)currentCardChanged {
    [self.view bringSubviewToFront:self.cardArray[self.currentCardIdx]];
    [self.cardArray enumerateObjectsUsingBlock:^(CardView *card, NSUInteger idx, BOOL *stop) {
        if(idx != self.currentCardIdx) {
            card.userInteractionEnabled = NO;
        } else {
            card.userInteractionEnabled = YES;
        }
    }];
}

- (void)animateToStableState {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.cardArray enumerateObjectsUsingBlock:^(CardView *card, NSUInteger idx, BOOL *stop) {
            [card setLocation:[CardLocation locationForIndex:card.lastLocation]];
        }];
    } completion:NULL];
    
}


- (void)addCard:(CardView *)card {
    [self.cardContainer addSubview:card];
    [self.cardArray addObject:card];
}

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset withDirection:(ScrollDirection)direction {
    cardView.center = CGPointMake(cardView.center.x, offset + [CardLocation locationForIndex:2].center.y);

    
    CGFloat ratio = offset/kThreshold;
    if(ratio > 1) {
        ratio = 1;
    }
    [self.cardArray enumerateObjectsUsingBlock:^(CardView *card, NSUInteger idx, BOOL *stop) {
        // Skip Current Card
        if(idx != self.currentCardIdx) {
            NSInteger startIndex = (2 - self.currentCardIdx) + idx;
            if(startIndex + 1 <= 6) {
                [card setLocation:[CardLocation locationForStart:startIndex end:startIndex+1 distancePercentage:ratio]];
            }
        }
    }];
}

- (void)endedDraggingWithCardView:(CardView *)cardView withDirection:(ScrollDirection)direction {
    
    // Thresholding
    CGFloat distanceTraveled = abs(cardView.center.y - [CardLocation locationForIndex:self.currentCardIdx].center.y);
    BOOL overThreshold = distanceTraveled >= kThreshold;
    
    // Limits
    BOOL isFirstCard = (self.currentCardIdx == 0);
    BOOL isLastCard = (self.currentCardIdx == self.cardArray.count -1);
    
    // Direction
    BOOL isDown = ScrollDirectionDown == direction;
    BOOL isUp = ScrollDirectionUp == direction;
    
    if(overThreshold && isDown && !isFirstCard) {
        [self moveCardDeck:CardDeckAnimateDirectionPrev];
    } else if(overThreshold && isUp && !isLastCard) {
        [self moveCardDeck:CardDeckAnimateDirectionNext];
    } else {
        [self animateToStableState];
    }
}



@end
