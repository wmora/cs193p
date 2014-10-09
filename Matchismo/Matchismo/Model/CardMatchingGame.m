//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by William Mora on 23/03/14.
//  Copyright (c) 2014 William Mora. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *matchedCards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)matchedCards
{
    if (!_matchedCards) {
        _matchedCards = [[NSMutableArray alloc] init];
    }
    
    return _matchedCards;
}

- (NSUInteger)cardMatchLimit
{
    if (!_cardMatchLimit) {
        _cardMatchLimit = 2;
    }
    
    return _cardMatchLimit;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index]:nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    //Once a card is matched is out of the game
    if (card.isMatched) {
        return;
    }
    
    //If the card is already chosen, just "unchoose it"
    if (card.isChosen) {
        card.chosen = NO;
        return;
    }
    
    if ([self.matchedCards count] > 0) {
        for (Card *otherCard in self.matchedCards) {
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                NSUInteger multipleMatchBonus = ([self.matchedCards count] > 0) ? ([self.matchedCards count] * 4) : 1;
                self.score += matchScore * MATCH_BONUS * multipleMatchBonus;
            }
        }
        card.matched = YES;
        [self.matchedCards addObject:card];
    } else {
        //match against other cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    NSUInteger multipleMatchBonus = ([self.matchedCards count] > 0) ? ([self.matchedCards count] * 4) : 1;
                    self.score += matchScore * MATCH_BONUS * multipleMatchBonus;
                    card.matched = YES;
                    otherCard.matched = YES;
                    if ([self.matchedCards count] == 0) {
                        [self.matchedCards addObject:card];
                    }
                    [self.matchedCards addObject:otherCard];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                }
            }
        }
    }
    
    if ([self.matchedCards count] >= self.cardMatchLimit) {
        self.matchedCards = nil;
    }
    
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

@end
