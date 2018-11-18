// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        for (NSString *shape in [SetCard validShapes])
        {
            for (NSString *color in [SetCard validColors])
            {
                for (int shade = 0; shade < [[SetCard validShades] count]; shade++)
                {
                    for (int rank = 0; rank < [[SetCard validRanks] count]; rank ++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = [[[SetCard validRanks] objectAtIndex:rank] integerValue];
                        card.shape = shape;
                        card.color = color;
                        card.shade = [[[SetCard validShades] objectAtIndex:shade] floatValue];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
