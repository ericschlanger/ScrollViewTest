//
//  ViewController.m
//  ScrollViewTest
//
//  Created by Michael MacDougall on 9/9/14.
//  Copyright (c) 2014 Michael MacDougall. All rights reserved.
//

#import "ViewController.h"
#import "CardDeck.h"

@interface ViewController () <CardDeckDelegate>

@property (nonatomic, strong) CardDeck *cardDeck;

@property (nonatomic, strong) NSMutableArray *cardArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardArray = [[NSMutableArray alloc] initWithObjects:@"Test0",@"Test1",@"Test2",@"Test3",@"Test4",@"Test5", nil];
    
    self.cardDeck = [[CardDeck alloc] initWithFrame:self.view.bounds andNumberOfCards:self.cardArray.count];
    self.cardDeck.delegate = self;
    [self.view addSubview:self.cardDeck];
}

// Use CardView's tag property to specify which card you want to reference
// Everything else is like TableViewDelegate, if you need headers and such
// you will need to delegate them from CardView -> CardDeck -> VC

#pragma mark - CardDeck Delegate

- (void)cardDeck:(CardDeck *)cardDeck didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCard:(CardView *)card {
    
    switch (card.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        default:
            break;
    }
}

- (UITableViewCell *)cardDeck:(CardDeck *)cardDeck cellForRowAtIndexPath:(NSIndexPath *)indexPath withCard:(CardView *)card {
    UITableViewCell *cell = [card.table dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.cardArray[card.tag];
    
    return cell;
}

- (NSInteger)cardDeck:(CardDeck *)cardDeck numberOfRowsInSection:(NSInteger)section forCard:(CardView *)card {
    switch (card.tag) {
        case 0:
            return 20;
        case 1:
            return 20;
        case 2:
            return 20;
        case 3:
            return 20;
        case 4:
            return 20;
        case 5:
            return 20;
        default:
            return 0;
    }
}

@end
