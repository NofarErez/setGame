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
static const int kInitialCardCount = 9;

@synthesize game = _game;
@synthesize grid = _grid;
@synthesize cardsView = _cardsView;

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (Game *)createGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:kInitialCardCount usingDeck:[self createDeck]];
    self.cardCount = kInitialCardCount;
    return _game;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    if(!self.deckStacked) {
        if([sender.view isKindOfClass:[PlayingCardView class]])
        {
            PlayingCardView *view = (PlayingCardView *)sender.view;
            view.chosen = !view.chosen;
        }
        
        NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:sender.view];
        [self performSelector:@selector(chooseCard:) withObject:[NSNumber numberWithUnsignedInteger:cardIndex] afterDelay:0.1];
    } else {
        [self tapToSpreadDeck:sender];
    }
    
}

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card
{
    if ([cardView isKindOfClass:[PlayingCardView class]]) {
        PlayingCardView *view = (PlayingCardView *)cardView;
        if ([card chosen] != [view chosen])
        {
            view.chosen = card.chosen;
        }
    }
}

- (void) addCardView:(CGPoint)initalPos atIndex:(NSUInteger)index {
    Card *card = [self.game cardAtIndex:index];
    NSUInteger column = index % [self.grid columnCount];
    NSUInteger row = index / [self.grid columnCount];
    CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
    PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:CGRectMake(-100, -100, frame.size.width * kCardFrameRatio, frame.size.height * kCardFrameRatio)];
    if ([card isKindOfClass:[PlayingCard class]])
    {
        cardView.rank = ((PlayingCard *)card).rank;
        cardView.suit = ((PlayingCard *)card).suit;
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [self.cardsView addSubview:cardView];
    }
    [self moveCard:cardView toRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * kCardFrameRatio, frame.size.height * kCardFrameRatio)];
}
@end

NS_ASSUME_NONNULL_END
