// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

NSUInteger kSimilarParameters = 1;
NSUInteger kUniqueParameters = 3;
NSUInteger kCardsToMatch = 3;




- (NSString *) contents
{
    return nil;
}

+ (BOOL) validParameter: (NSSet *)parameters
{
    return [parameters count] == kSimilarParameters || [parameters count] == kUniqueParameters;
}

- (BOOL) matchShape: (NSArray *)cards
{
    NSSet *shapes = [NSSet setWithArray:[cards valueForKey:@"shape"]];
    return [SetCard validParameter:shapes];
}

- (BOOL) matchRank: (NSArray *)cards
{
    NSSet *ranks = [NSSet setWithArray:[cards valueForKey:@"rank"]];
    return [SetCard validParameter:ranks];
}

- (BOOL) matchColor: (NSArray *)cards
{
    NSSet *colors = [NSSet setWithArray:[cards valueForKey:@"color"]];
    return [SetCard validParameter:colors];
}

- (BOOL) matchShade: (NSArray *)cards
{
    NSSet *shades = [NSSet setWithArray:[cards valueForKey:@"shade"]];
    return [SetCard validParameter:shades];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == kCardsToMatch - 1)
    {
        NSMutableArray *cards = [NSMutableArray arrayWithArray:otherCards]; // copy?
        [cards addObject:self];
        if([self matchRank:cards] && [self matchColor:cards] &&
           [self matchShape:cards] && [self matchShade:cards])
        {
            score = 3;
        }
    }
    
    return score;
}

+ (NSArray *) validShapes
{
    return @[@"▲", @"■", @"●"];
}

+ (NSArray *) validShades
{
    return @[@0.3, @0.6, @1.0];
}

+ (NSArray *) validColors
{
    return @[@"red", @"blue", @"green"];
}

+ (NSArray *) validRanks
{
    return @[@1, @2, @3];
}


@end

NS_ASSUME_NONNULL_END
