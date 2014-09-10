//
//  CardDeck.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/3/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "CardDeck.h"

#import "CardView.h"

#import "CardLocation.h"

static const CGFloat kThreshold = 50;

typedef NS_ENUM(NSUInteger, CardDeckAnimateDirection) {
    CardDeckAnimateDirectionPrev,
    CardDeckAnimateDirectionNext
};

@interface CardDeck () <CardViewDelegate>

@property (nonatomic, strong) UIView *cardContainer;
@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic) NSInteger currentCardIdx;

@end

@implementation CardDeck

- (id)initWithFrame:(CGRect)frame andNumberOfCards:(NSInteger)numOfCards {
    self = [super initWithFrame:frame];
    if(self) {
        self.cardContainer = [[UIView alloc] initWithFrame:self.bounds];
        self.cardContainer.backgroundColor = [UIColor blueColor];
        [self addSubview:self.cardContainer];
        [self setupCardsWithNumOfCards:numOfCards];
    }
    return self;
}

- (void)setupCardsWithNumOfCards:(NSInteger)numOfCards {
    self.cardArray = [[NSMutableArray alloc]init];
    
    CGRect cardFrame = CGRectMake(0, 0, 320, 438.5);
    
    
    for(NSInteger i=0;i<numOfCards;i++) {
        CardView *card = [[CardView alloc] initWithFrame:cardFrame];
        card.tag = i;
        card.delegate = self;
        [card setLocation:[CardLocation locationForIndex:i]];
        card.backgroundColor = [UIColor grayColor];
        [self.cardArray addObject:card];
    }
    
    for(NSInteger i=0;i<=2;i++) {
        if(self.cardArray.count > i) {
            [self.cardContainer addSubview:self.cardArray[i]];
        } else {
            break;
        }
    }
    
    for(NSInteger i=numOfCards - 1;i>=3;i--) {
        if(self.cardArray.count >= i) {
            [self.cardContainer addSubview:self.cardArray[i]];
        } else {
            break;
        }
    }
    
    // Edge cases (1 & 2 cards)
    if(numOfCards == 2) {
        CardView *card = self.cardArray[0];
        [card setLocation:[CardLocation locationForIndex:1]];
        CardView *cardTwo = self.cardArray[1];
        [cardTwo setLocation:[CardLocation locationForIndex:2]];
    } else if(numOfCards == 1) {
        CardView *card = self.cardArray[0];
        [card setLocation:[CardLocation locationForIndex:2]];
    }
    self.currentCardIdx = numOfCards <= 2 ? numOfCards - 1 : 2;
    
    [self disableAllCardsExceptIndex:self.currentCardIdx];
    [self.cardContainer bringSubviewToFront:self.cardArray[self.currentCardIdx]];
}

- (void)moveCardDeck:(CardDeckAnimateDirection)direction animated:(BOOL)animated {
    NSTimeInterval duration = animated ? .3 : 0;
    self.userInteractionEnabled = NO;
    if(direction == CardDeckAnimateDirectionNext) {
        [self disableAllCardsExceptIndex:self.currentCardIdx + 1];
       [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
            CardView *currentCard = self.cardArray[self.currentCardIdx];
            [currentCard scrollCardToTop];
            self.currentCardIdx += 1;
            self.userInteractionEnabled = YES;
        }];
        
    } else if(direction == CardDeckAnimateDirectionPrev) {
        [self disableAllCardsExceptIndex:self.currentCardIdx - 1];
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
            CardView *currentCard = self.cardArray[self.currentCardIdx];
            [currentCard scrollCardToTop];
            self.currentCardIdx -= 1;
            self.userInteractionEnabled = YES;
        }];
    }
}

- (void)disableAllCardsExceptIndex:(NSInteger)index {
    [self.cardArray enumerateObjectsUsingBlock:^(CardView *card, NSUInteger idx, BOOL *stop) {
        if(idx != index) {
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

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset withDirection:(ScrollDirection)direction {
    [self.cardContainer bringSubviewToFront:cardView];
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

- (void)cardViewDidMoveHalfWay:(CardView *)cardView aboveHalfwayMark:(BOOL)isAbove {
    if(!isAbove && self.currentCardIdx + 1 < self.cardArray.count) {
        [self.cardContainer bringSubviewToFront:self.cardArray[self.currentCardIdx+1]];
    } else if(isAbove) {
        [self.cardContainer bringSubviewToFront:self.cardArray[self.currentCardIdx]];
    }
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
        [self moveCardDeck:CardDeckAnimateDirectionPrev animated:YES];
    } else if(overThreshold && isUp && !isLastCard) {
        [self moveCardDeck:CardDeckAnimateDirectionNext animated:YES];
    } else {
        [self animateToStableState];
    }
}

- (NSInteger)cardView:(CardView *)cardView numberOfRowsinSection:(NSInteger)section {
    return [self.delegate cardDeck:self numberOfRowsInSection:section forCard:cardView];
}

- (UITableViewCell *)cardView:(CardView *)cardView cellForIndexAtPath:(NSIndexPath *)indexPath {
    return [self.delegate cardDeck:self cellForRowAtIndexPath:indexPath withCard:cardView];
}

- (void)cardView:(CardView *)cardView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate cardDeck:self didSelectRowAtIndexPath:indexPath withCard:cardView];
}






@end
