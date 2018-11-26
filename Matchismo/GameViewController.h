// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

// Abstract class that is the super of matching games controllers.
@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cardSelectionLabel;
@property (strong, nonatomic) Game *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) NSArray *cards;

// A method that returns the representation of a card.
- (NSAttributedString *) titleForCard: (Card *)card;

// A method that return the background image of a card given its status.
- (UIImage *) backgroundImageForCard: (Card *)card;

//A method that returns the representationof a card given its status.
- (NSAttributedString *) buttonTitleForCard:(Card *)card;

// Method to create a new instance of a deck.
- (Deck *) createDeck;

- (void)drawCards;

- (void) updateUIMatchingResult;

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card;

- (Game *)createGame;

@end

NS_ASSUME_NONNULL_END

