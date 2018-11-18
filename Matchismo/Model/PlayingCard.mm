//
//  PlayingCard.m
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

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

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit])
        {
            score = 6;
        }
        else if (self.rank == otherCard.rank)
        {
            score = 12;
        }
    }
    
    return score;
}


@end
