// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetDeck

- (instancetype)init
{
    if (self = [super init])
    {
        for (int shape = 0; shape < kUniqueParameters; shape++)
        {
            for (int color = 0; color < kUniqueParameters; color++)
            {
                for (int fill = 0; fill < kUniqueParameters; fill++)
                {
                    for (int rank = 0; rank < kUniqueParameters; rank ++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.shape = shape;
                        card.color = color;
                        card.fill = fill;
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
