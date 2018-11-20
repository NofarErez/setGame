// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
       for (NSString *suit in [PlayingCard validSuits])
       {
           for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank ++)
           {
               PlayingCard *card = [[PlayingCard alloc] init];
               card.rank = rank;
               card.suit = suit;
               [self addCard:card];
           }
       }
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
