// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "MatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"


NS_ASSUME_NONNULL_BEGIN

@interface MatchingGameViewController()

@end

@implementation MatchingGameViewController
static const int kCardCount = 12;

@synthesize game = _game;
@synthesize grid = _grid;
@synthesize cardsView = _cardsView;

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (Game *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:kCardCount usingDeck:[self createDeck]];
    }
    return _game;
}

- (Game *)createGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:kCardCount usingDeck:[self createDeck]];
    return _game;
}


- (void)drawCards {
    for (int i = 0; i < kCardCount; i++)
    {
        Card *card = [self.game cardAtIndex:i];
        int column = i / [self.grid rowCount];
        int row = i % [self.grid rowCount];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:CGRectMake(-100, -100, frame.size.width * 0.9, frame.size.height * 0.9)];
        if ([card isKindOfClass:[PlayingCard class]])
        {
            cardView.rank = ((PlayingCard *)card).rank;
            cardView.suit = ((PlayingCard *)card).suit;
            [cardView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)]];
            [self.cardsView addSubview:cardView];
        }
        [self moveCard:cardView toRect:frame];
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if([sender.view isKindOfClass:[PlayingCardView class]])
    {
        PlayingCardView *view = (PlayingCardView *)sender.view;
        view.chosen = !view.chosen;
    }
    
    NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:sender.view];
    [self performSelector:@selector(chooseCard:) withObject:[NSNumber numberWithUnsignedInteger:cardIndex] afterDelay:0.1];
}

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card
{
    if ([cardView isKindOfClass:[PlayingCardView class]]) {
        PlayingCardView *view = (PlayingCardView *)cardView;
        if (![card chosen] && [view chosen])
        {
            view.chosen = card.chosen;
        }
    }
}

@end

NS_ASSUME_NONNULL_END
