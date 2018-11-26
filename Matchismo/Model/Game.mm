// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger score;

@end

@implementation Game

//static const int kMismatchPenaltyScore = 2;
//static const int kMatchBonusScore = 4;
//static const int kCostToChoose = 1;

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    if (self = [super init])
    {
        [self createCards];
        [self createTestMatchCards];
        
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype) init
{
    return nil;
}

- (BOOL) foundMatches
{
    return [[self.testMatchCards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.%K == %@", @"matched", @YES]] count] > 0;
}

- (void) createCards
{
    if(!self.cards)
    {
        self.cards = [[NSMutableArray alloc] init];
    }
}

- (void) createTestMatchCards
{
    if(!self.testMatchCards)
    {
        self.testMatchCards = [[NSMutableArray alloc] init];
    }
}

- (BOOL) readyToMatch
{
    return [self.testMatchCards count] == self.matchMode;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}

- (void)removeCardAtIndex:(NSUInteger)index {
  if (index >= 0)
  {
      [self.cards removeObjectAtIndex:index];
  }
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    //remove all objects after testing for a match
    if([self.testMatchCards count] == self.matchMode)
    {
        [self.testMatchCards filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.%K == %@  && SELF.%K == %@", @"chosen", @YES, @"matched", @NO]];
    }
    
    Card *card = [self cardAtIndex:index];
    if (card && !card.matched)
    {
        if (card.chosen)
        {
            card.chosen = NO;
            [self.testMatchCards removeObjectsInArray:@[card]];
        }
        
        else
        {
            card.chosen = YES;
            [self.testMatchCards addObject:card];
            
            if([self.testMatchCards count] == self.matchMode)
            {
                //check if there are any matches
                int matchScore = [self matchCards];
                
                // check if any of the cards matchd
                // if yes - turn all of them to matched
                // else - turn all but the last to not chosen
                if (matchScore)
                {
                    self.score += matchScore * kMatchBonusScore;
                    [self.testMatchCards setValue:@YES forKey:@"matched"];
                }
                else
                {
                    self.score -= kMismatchPenaltyScore;
                    NSRange badCardsRange;
                    badCardsRange.location = 0;
                    badCardsRange.length = [self.testMatchCards count] - 1;
                    NSArray *firstObjects = [self.testMatchCards
                                             subarrayWithRange:badCardsRange];
                    
                    [firstObjects setValue:@NO forKey:@"chosen"];
                }
            }
            
            self.score -= kCostToChoose;
        }
    }
}

- (int) matchCards
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end

NS_ASSUME_NONNULL_END
