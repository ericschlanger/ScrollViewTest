

#import <UIKit/UIKit.h>
#import "CardView.h"

@class CardDeck;

@protocol CardDeckDelegate

- (NSInteger)cardDeck:(CardDeck *)cardDeck numberOfRowsInSection:(NSInteger)section forCard:(CardView *)card;
- (UITableViewCell *)cardDeck:(CardDeck *)cardDeck cellForRowAtIndexPath:(NSIndexPath *)indexPath withCard:(CardView *)card;
- (void)cardDeck:(CardDeck *)cardDeck didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCard:(CardView *)card;

@end

@interface CardDeck : UIView

- (id)initWithFrame:(CGRect)frame andNumberOfCards:(NSInteger)numOfCards;

@property (nonatomic,weak) id<CardDeckDelegate> delegate;

@end
