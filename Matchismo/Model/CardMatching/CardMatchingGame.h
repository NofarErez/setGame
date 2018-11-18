// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;

- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSUInteger matchMode;

@property (strong, nonatomic) NSMutableArray *testMatchCards;

@property (nonatomic) BOOL readyToMatch;

@property (nonatomic) BOOL foundMatches;



@end

NS_ASSUME_NONNULL_END
