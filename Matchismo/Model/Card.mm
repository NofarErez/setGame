// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card()

@end

@implementation Card

+ (int)match:(NSArray *)otherCards
{
    NSLog(@"wrong place");
    int score = 0;
    
    for (int i = 0; i < [otherCards count]; i++)
    {
        Card *card = otherCards[i];
        for (int j = 0; j < [otherCards count] && j < i; j++)
        {
            Card *otherCard = otherCards[j];
            if ([card.contents isEqualToString:otherCard.contents])
            {
                score += 1;
            }
        }
    }
    
    return score;
}

@end

NS_ASSUME_NONNULL_END
