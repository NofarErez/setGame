// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

// Object used as a Card Matching card.
@interface PlayingCard : Card

// The suit of the card. possible values are ♣️, ♥️, ♦️, ♠️.
@property (strong, nonatomic) NSString *suit;

// The rank of the card, possible values are A, 2, .... , 10, J, Q, K.
@property (nonatomic) NSUInteger rank;

// Method that return the valid suits for a card.
+ (NSArray *)validSuits;

// Method that returns the maximum value of a card rank.
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
