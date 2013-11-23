//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ethan Petuchowski on 11/12/13.
//  Copyright (c) 2013 Ethan Petuchowski. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

/* we can redefine score to be readwrite here in the implementation */
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card [no type-parameters]
@property (nonatomic, strong) NSMutableArray *faceUpCards; // of Carrd
@end

@implementation CardMatchingGame

/* dynamic allocation for reference properties go in the getter */
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)faceUpCards
{
    if (!_faceUpCards) _faceUpCards = [[NSMutableArray alloc] init];
    return _faceUpCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init]; /* bc we're init'ing a subclass, 
                          note there's no alloc bc it's `self`
                          and the caller has to call alloc first */
    if (self) {
        // note we're going to "match" on value XOR suit
        // because drawRandomCard actually removes the card
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            [self.cards addObject:card]; /* calls constructor if necessary */
        }
    }
    
    return self;
}

- (int)numCardsToMatch
{
    if (!_numCardsToMatch) _numCardsToMatch = 3;
    return _numCardsToMatch;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)cardAtIndex:(NSUInteger)index
{
    // guard Error ArrayIndexOutOfBounds
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (void)markAllCardsAsMatched
{
    for (Card *card in self.faceUpCards) {
        card.matched = YES;
    }
    [self.faceUpCards removeAllObjects];
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            // if it's face-up, flip it back down
            card.chosen = NO; // setter has different name than getter (no reason?)
            [self.faceUpCards removeObject:card];
        } else {  // match against other chosen cards
            card.chosen = YES;
            if ([self.faceUpCards count] >= self.numCardsToMatch - 1) {
                int matchScore = [card match:self.faceUpCards];
                [self.faceUpCards addObject:card];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    [self markAllCardsAsMatched]; // from assn: ALL get removed
                    self.score += matchScore;
                } else {
                    // flip oldest card back over
                    Card *oldCard = [self.faceUpCards objectAtIndex:0];
                    oldCard.chosen = NO;
                    [self.faceUpCards removeObjectAtIndex:0];
                    self.score -= MISMATCH_PENALTY;
                }
            } else {
                [self.faceUpCards addObject:card];
            }
            self.score -= COST_TO_CHOOSE;
        }
    }
}

@end
