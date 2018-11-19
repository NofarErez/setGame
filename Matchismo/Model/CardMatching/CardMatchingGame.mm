// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "CardMatchingGame.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardMatchingGame

@synthesize matchMode = _matchMode;

typedef NS_OPTIONS(NSUInteger, MatchMode)
{
    MatchModeTwo = 2,
    MatchModeThree = 3
} ;

- (void) setMatchMode:(NSUInteger)matchMode
{
    
    _matchMode = matchMode == MatchModeThree ? MatchModeThree : MatchModeTwo;
}


- (int) matchCards
{
    return [PlayingCard match:self.testMatchCards];
}

@end

NS_ASSUME_NONNULL_END
