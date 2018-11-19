// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (Card *) cardAtIndex:(NSUInteger)index;

- (void) chooseCardAtIndex:(NSUInteger)index;

- (int) matchCards;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSUInteger matchMode;

@property (strong, nonatomic) NSMutableArray *testMatchCards;

@property (nonatomic) BOOL readyToMatch;

@property (nonatomic) BOOL foundMatches;

@end

static const int kMismatchPenaltyScore = 2;
static const int kMatchBonusScore = 4;
static const int kCostToChoose = 1;

NS_ASSUME_NONNULL_END
