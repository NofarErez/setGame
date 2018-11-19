//
//  Card.m
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

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
