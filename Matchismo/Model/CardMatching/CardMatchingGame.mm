// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

static const int kMismatchPenaltyScore = 2;
static const int kMatchBonusScore = 4;
static const int kCostToChoose = 1;

typedef NS_OPTIONS(NSUInteger, MatchMode)
{
    MatchModeTwo = 2,
    MatchModeThree = 3
} ;

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

- (void) setMatchMode:(NSUInteger)matchMode
{
    
    _matchMode = matchMode == MatchModeThree ? MatchModeThree : MatchModeTwo;
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
                [self matchCards];
                
                // check if any of the cards matchd
                // if yes - turn all of them to matched
                // else - turn all but the last to not chosen
                if (self.foundMatches)
                {
                    [self.testMatchCards setValue:@YES forKey:@"matched"];
                }
                else
                {
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

- (void) matchCards
{
    for (int i = 0; i < [self.testMatchCards count]; i++)
    {
        Card *card = self.testMatchCards[i];
        for (int j = 0; j < [self.testMatchCards count] && j < i; j++)
        {
            Card *otherCard = self.testMatchCards[j];
            int matchScore = [card match:@[otherCard]];
            if (matchScore)
            {
                //cards match!!
                self.score += (matchScore / self.matchMode) * kMatchBonusScore;
                otherCard.matched = YES;
                card.matched = YES;
            }
            
            else
            {
                // cards doesn't match :(
                self.score -= kMismatchPenaltyScore;
            }
        }
    }
}


- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}

@end

NS_ASSUME_NONNULL_END
