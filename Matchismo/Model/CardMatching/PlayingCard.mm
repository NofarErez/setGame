// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankString = [PlayingCard rankString];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger) rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♣️", @"♥️", @"♦️", @"♠️"];
}

+ (NSUInteger)maxRank
{
    return [[self rankString] count] - 1;
}

+ (NSArray *)rankString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (int)match:(NSArray *)cards
{
    int score = 0;
    
    for (int i = 0; i < [cards count]; i++)
    {

        PlayingCard *card = cards[i];
        for (int j = 0; j < [cards count] && j < i; j++)
        {
            PlayingCard *otherCard = cards[j];
            if ([card.suit isEqualToString:otherCard.suit])
            {
                score += 1;
            }
            else if (card.rank == otherCard.rank)
            {
                score += 4;
            }
        }
    }
    
    return score;
}


@end

NS_ASSUME_NONNULL_END
