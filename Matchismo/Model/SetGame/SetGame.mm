// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetGame.h"
#import "SetCard.h"
NS_ASSUME_NONNULL_BEGIN

@implementation SetGame

- (int) matchCards
{
    return [SetCard match:self.testMatchCards];
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    if (self = [super initWithCardCount:count usingDeck:deck])
    {
        self.matchMode = 3;
    }
    
    return self;
}


@end

NS_ASSUME_NONNULL_END
