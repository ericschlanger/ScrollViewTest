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
    
    self.lastYOffset = card2.center.y;
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
    
    CardView *card1 = self.cardArray[self.currentCardIdx-1];
    CardView *card0 = self.cardArray[self.currentCardIdx-2];
    
    CGFloat ratio = offset/kThreshold;
    if(ratio > 1) {
        ratio = 1;
    }
    
    [card0 setLocation:[CardLocation locationForStart:0 end:1 distancePercentage:ratio]];
    [card1 setLocation:[CardLocation locationForStart:1 end:2 distancePercentage:ratio]];

}

- (void)endedDraggingWithCardView:(CardView *)cardView {
    
    CGFloat distanceTraveled = abs(cardView.center.y - center2);
    if(distanceTraveled >= kThreshold) {
        [self moveCardDeck:CardDeckAnimateDirectionNext];
    }

    self.lastYOffset = cardView.center.y;
    
}



@end
