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

static const CGFloat kCardDistanceFromBottom = 44;
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
// Location 3
static const CGFloat kCardYLoc = 85.5;

@interface MainViewController () <CardViewDelegate>

@property (nonatomic, strong) UIView *cardContainer;
@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic, strong) NSNumber *currentCardIdx;

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
}

- (void)setupCards {
    self.cardArray = [[NSMutableArray alloc]init];
    
//    for(int i=3;i>0;i--) {
//        CardView *cardView = [[CardView alloc]initWithFrame:CGRectMake(0,
//                                                                       kCardYLoc - i*13,
//                                                                       self.cardContainer.frame.size.width,
//                                                                       self.view.frame.size.height - kCardYLoc - kCardDistanceFromBottom)];
////        cardView.layer.transform = CATransform3DConcat(cardView.layer.transform, CATransform3DMakeRotation(DEGREES_TO_RADIANS(10),1.0,0.0,0.0));
//        
//        switch (i) {
//            case 0:
//                cardView.backgroundColor = [UIColor redColor];
//                break;
//            case 1:
//                cardView.backgroundColor = [UIColor greenColor];
//                break;
//            case 2:
//                cardView.backgroundColor = [UIColor blueColor];
//                break;
//            default:
//                cardView.backgroundColor = [UIColor magentaColor];
//                break;
//        }
//
//        cardView.delegate = self;
//        [self.cardContainer addSubview:cardView];
//        [self.cardArray addObject:cardView];
//    }
    
    CardView *card1 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card1.delegate = self;
    [self addCard:card1];
    [card1 setLocation:[CardLocation locationForIndex:1]];
    
    CardView *card2 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card2.delegate = self;
    [self addCard:card2];
    [card2 setLocation:[CardLocation locationForIndex:2]];
    
    CardView *card3 = [[CardView alloc]initWithFrame:CGRectMake(0, 0, 320, 438.5)];
    card3.delegate = self;
    [self addCard:card3];
    [card3 setLocation:[CardLocation locationForIndex:3]];
}

- (void)addCard:(CardView *)card {
    [self.cardContainer addSubview:card];
    [self.cardArray addObject:card];
}

- (void)cardView:(CardView *)cardView moveWithOffset:(CGFloat)offset {
    CGRect oldFrame = cardView.frame;
    oldFrame.origin.y = oldFrame.origin.y - offset;
    cardView.frame = oldFrame;
    
}



@end
