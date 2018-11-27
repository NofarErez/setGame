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

// Method to create a new instance of a deck.
- (Deck *) createDeck;

- (Game *)createGame;

- (void)drawCards;

- (void)updateUIMatchingResult;

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card;

- (void)moveCard:(UIView *)cardView toRect:(CGRect)finalPos;

- (void) chooseCard:(NSNumber *)cardIndex;

@end

NS_ASSUME_NONNULL_END

