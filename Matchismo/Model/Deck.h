// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

// Object used as an abstract class representing a deck of cards.
@interface Deck : NSObject

// Method that adds /c card to the top of the deck.
- (void)addCard:(Card *) card atTop:(BOOL)atTop;

// Method that adds /c card to the deck.
- (void)addCard:(Card *) card;

// Method that draws a random card form the deck.
- (Card *)drawRandomCard;

- (BOOL)empty;

@end

NS_ASSUME_NONNULL_END
