// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

// Abstract class that is the super of matching games controllers.
@interface GameViewController : UIViewController

@property (strong, nonatomic) Game *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (strong, nonatomic) Grid *grid;

// Number of card on the board of the game.
@property (nonatomic) NSUInteger cardCount;

// A property that state whether the deck is stacked.
@property (nonatomic) BOOL deckStacked;


// Method to create a new instance of a deck.
- (Deck *) createDeck;

// Method to create a new instance of a card game.
- (Game *)createGame;

// Method to draw the card on the game board.
- (void)drawCards;

// Method to move \c cardView to the frame \c finalPos.
- (void)moveCard:(UIView *)cardView toRect:(CGRect)finalPos;

// Method to choose card at \c cardIndex.
- (void) chooseCard:(NSNumber *)cardIndex;

// Method that add a card view in \c initialPos at \c index.
- (void) addCardView:(CGPoint)initalPos atIndex:(NSUInteger)index;

// Method that recognize the tap gesture and spread the cards on the board.
- (IBAction)tapToSpreadDeck:(UITapGestureRecognizer *)sender;

@end

const static float kCardFrameRatio = 0.9;

NS_ASSUME_NONNULL_END

