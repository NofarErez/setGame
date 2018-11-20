// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

// Object used as an abstract class representing a deck of cards.
@interface Game : NSObject

// Designated initialiser that init the class with /c count cards from /c deck.
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

// Method that returns the card that is found in /c index.
- (Card *) cardAtIndex:(NSUInteger)index;

// Method that preforms the choosing process of a card, If neceassery also preform the matching process of all cards.
- (void) chooseCardAtIndex:(NSUInteger)index;

// Abstract method that preform the actual matching of cards.
- (int) matchCards;

// The score of the game.
@property (nonatomic, readonly) NSInteger score;

// The number of cards needed to preform a match.
@property (nonatomic) NSUInteger matchMode;

// The already chosen cards that need to be matched.
@property (strong, nonatomic) NSMutableArray *testMatchCards;

// A boolean status to indicate wheather enough cards has been chosen.
@property (nonatomic) BOOL readyToMatch;

// A boolean status to indicate wheather a match has been found.
@property (nonatomic) BOOL foundMatches;

@end

static const int kMismatchPenaltyScore = 2;
static const int kMatchBonusScore = 4;
static const int kCostToChoose = 1;

NS_ASSUME_NONNULL_END
